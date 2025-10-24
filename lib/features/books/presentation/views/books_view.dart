import 'package:bookly/core/api/api_service.dart';
import 'package:bookly/features/books/data/datasources/books_local_data_source.dart';
import 'package:bookly/features/books/data/datasources/books_remote_data_source.dart';
import 'package:bookly/features/books/data/repositories/books_repository_impl.dart';
import 'package:bookly/features/books/domain/usecases/get_featured_books_usecase.dart';
import 'package:bookly/features/books/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import 'package:bookly/features/books/presentation/views/widgets/books_view_body.dart';
import 'package:bookly/features/books/presentation/views/widgets/glassmorphism_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BooksView extends StatelessWidget {
  const BooksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeaturedBooksCubit(
        getFeaturedBooksUseCase: GetFeaturedBooksUseCase(
          booksRepository: BooksRepositoryImpl(
              remoteDataSource: BooksRemoteDataSourceImpl(
                apiService: ApiService(),
              ),
              localDataSource: const BooksLocalDataSourceImpl()),
        ),
      )..getFeaturedBooks(),
      child: const Scaffold(
        body: Stack(
          children: [
            SafeArea(
              child: BooksViewBody(),
            ),
            GlassmorphismBottomNavigationBar(),
          ],
        ),
      ),
    );
  }
}
