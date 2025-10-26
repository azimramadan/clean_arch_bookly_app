import 'package:bookly/core/service_locator.dart';
import 'package:bookly/features/books/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import 'package:bookly/features/books/presentation/manager/newest_books_cubit/newest_books_cubit.dart';
import 'package:bookly/features/books/presentation/views/widgets/books_view_body.dart';
import 'package:bookly/features/books/presentation/views/widgets/glassmorphism_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BooksView extends StatelessWidget {
  const BooksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<FeaturedBooksCubit>()..getFeaturedBooks(),
        ),
        BlocProvider(
          create: (context) => getIt<NewestBooksCubit>()..getNewestBooks(),
        ),
      ],
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
