import 'package:bookly/features/books/domain/entities/book_entity.dart';
import 'package:bookly/features/books/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import 'package:bookly/features/books/presentation/views/widgets/custom_book_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeaturedBooksListView extends StatefulWidget {
  const FeaturedBooksListView({
    super.key,
    this.onPageChanged,
    required this.books,
  });

  final Function(int)? onPageChanged;
  final List<BookEntity> books;
  @override
  FeaturedBooksListViewState createState() => FeaturedBooksListViewState();
}

class FeaturedBooksListViewState extends State<FeaturedBooksListView> {
  late ScrollController _scrollController;
  int _booksLength = 0;
  int _currentIndex = 0;
  double _currentScrollOffset = 0;

  final double _baseItemWidth = 140;
  final double _largeItemWidth = 160;

  int nextPage = 1;
  bool isLoadingMore = false;
  @override
  void initState() {
    super.initState();
    _booksLength = widget.books.length;
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() async {
    final cubit = context.read<FeaturedBooksCubit>();
    final state = cubit.state;

    if (isLoadingMore || state is FeaturedBooksPaginationLoading) return;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      setState(() => isLoadingMore = true);

      await cubit.getFeaturedBooks(pageNumber: nextPage++);

      if (!mounted) return;
      setState(() => isLoadingMore = false);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _currentScrollOffset = _scrollController.offset;

      double screenWidth = MediaQuery.of(context).size.width;
      double quarterScreen = screenWidth * 0.25;

      int newFocusedIndex = -1;
      double minDistance = double.infinity;

      for (int i = 0; i < widget.books.length; i++) {
        double itemPosition = _getItemPosition(i);

        if (itemPosition >= 0 && itemPosition <= quarterScreen) {
          double distanceFromQuarter = (itemPosition - quarterScreen / 2).abs();
          if (distanceFromQuarter < minDistance) {
            minDistance = distanceFromQuarter;
            newFocusedIndex = i;
          }
        }
      }

      if (newFocusedIndex == -1) {
        double totalItemWidth = _baseItemWidth;
        newFocusedIndex = (_currentScrollOffset / totalItemWidth).round();
        if (widget.books.isEmpty) return;
        newFocusedIndex = newFocusedIndex.clamp(0, _booksLength - 1);
      }

      if (newFocusedIndex != _currentIndex) {
        _currentIndex = newFocusedIndex;

        if (widget.onPageChanged != null) {
          widget.onPageChanged!(_currentIndex);
        }
      }
    });
  }

  double _getItemPosition(int index) {
    double totalItemWidth = _baseItemWidth;
    return (index * totalItemWidth) - _currentScrollOffset;
  }

  double _getItemWidth(int index) {
    if (index == _currentIndex) {
      return _largeItemWidth;
    } else {
      return _baseItemWidth;
    }
  }

  void scrollToIndex(int index) {
    if (!_scrollController.hasClients || widget.books.isEmpty) return;

    double totalItemWidth = _baseItemWidth;
    double targetOffset = index * totalItemWidth;

    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .28,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(
          left: 20,
        ),
        physics: const BouncingScrollPhysics(),
        itemCount: _booksLength,
        itemBuilder: (BuildContext context, int index) {
          bool isActive = index == _currentIndex;
          double width = _getItemWidth(index);

          return Container(
            width: isActive ? width - 20 : width,
            margin: EdgeInsets.only(
              right: isActive ? 6 : 0,
              left: isActive && index != 0 ? 6 : 0,
            ),
            child: GestureDetector(
              onTap: () {
                scrollToIndex(index);
              },
              child: CustomBookImage(
                scale: isActive ? .95 : 0.80,
                imagePath: widget.books[index].imageUrl,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void didUpdateWidget(covariant FeaturedBooksListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _booksLength = widget.books.length;
  }
}
