import 'package:bookly/core/utils/styles.dart';
import 'package:bookly/features/books/domain/entities/book_entity.dart';
import 'package:bookly/features/books/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import 'package:bookly/features/books/presentation/views/widgets/custom_sliver_app_bar.dart';
import 'package:bookly/features/books/presentation/views/widgets/featured_books_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'best_seller_list_view.dart';

class BooksViewBody extends StatelessWidget {
  const BooksViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        CustomSliverAppBar(),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              FeaturedBooksListViewBlocConsumer(),
              SizedBox(height: 25),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Best Seller',
                  style: Styles.textStyle18,
                ),
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
        BestSellerListView(),
      ],
    );
  }
}

class FeaturedBooksListViewBlocConsumer extends StatelessWidget {
  const FeaturedBooksListViewBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeaturedBooksCubit, FeaturedBooksState>(
      listener: (context, state) {
        if (state is FeaturedBooksPaginationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 3),
              action: SnackBarAction(
                label: 'Dismiss',
                textColor: Colors.white,
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state) {
          case FeaturedBooksInitial():
          case FeaturedBooksLoading():
            return Skeletonizer(
              enabled: true,
              child: FeaturedBooksListView(
                books: List.filled(
                  10,
                  BookEntity(
                      bookId: '',
                      title: '',
                      author: '',
                      imageUrl: "https://i.pravatar.cc/150?img=3",
                      price: 12,
                      rating: ''),
                ),
              ),
            );
          case FeaturedBooksSuccess():
            return FeaturedBooksListView(books: state.books);
          case FeaturedBooksPaginationLoading():
            return FeaturedBooksListView(books: state.books);
          case FeaturedBooksPaginationFailure():
            return FeaturedBooksListView(books: state.books);
          case FeaturedBooksFailure():
            return Center(
              child: Text(
                state.errorMessage,
                style: Styles.textStyle18,
              ),
            );
        }
      },
    );
  }
}
