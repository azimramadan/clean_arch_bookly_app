import 'package:bookly/core/utils/styles.dart';
import 'package:bookly/features/books/domain/entities/book_entity.dart';
import 'package:bookly/features/books/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import 'package:bookly/features/books/presentation/manager/newest_books_cubit/newest_books_cubit.dart';
import 'package:bookly/features/books/presentation/views/widgets/best_seller_list_view.dart';
import 'package:bookly/features/books/presentation/views/widgets/custom_sliver_app_bar.dart';
import 'package:bookly/features/books/presentation/views/widgets/featured_books_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BooksViewBody extends StatefulWidget {
  const BooksViewBody({Key? key}) : super(key: key);

  @override
  State<BooksViewBody> createState() => _BooksViewBodyState();
}

class _BooksViewBodyState extends State<BooksViewBody> {
  final ScrollController _scrollController = ScrollController();
  int nextPage = 1;
  bool isLoadingMore = false;

  void _scrollListener() async {
    final cubit = context.read<NewestBooksCubit>();
    final state = cubit.state;

    if (isLoadingMore || state is NewestBooksPaginationLoading) return;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      setState(() => isLoadingMore = true);

      await cubit.getNewestBooks(pageNumber: nextPage++);

      if (!mounted) return;
      setState(() => isLoadingMore = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: const [
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
        NewestBooksListViewWithBlocConsumer(),
      ],
    );
  }
}

class NewestBooksListViewWithBlocConsumer extends StatelessWidget {
  const NewestBooksListViewWithBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewestBooksCubit, NewestBooksState>(
      listener: (context, state) {
        if (state is NewestBooksPaginationFailure) {
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
          case NewestBooksInitial():
          case NewestBooksLoading():
            return SliverToBoxAdapter(
              child: Skeletonizer(
                enabled: true,
                child: NewestBooksListView(
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
              ),
            );
          case NewestBooksSuccess():
            return NewestBooksListView(books: state.newestBooks);
          case NewestBooksPaginationLoading():
            return NewestBooksListView(books: state.newestBooks);
          case NewestBooksPaginationFailure():
            return NewestBooksListView(books: state.newestBooks);
          case NewestBooksFailure():
            return SliverToBoxAdapter(
              child: Center(
                child: Text(
                  state.errorMessage,
                  style: Styles.textStyle18,
                ),
              ),
            );
        }
      },
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
