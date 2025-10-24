part of 'featured_books_cubit.dart';

@immutable
sealed class FeaturedBooksState {}

final class FeaturedBooksInitial extends FeaturedBooksState {}

class FeaturedBooksLoading extends FeaturedBooksState {}

class FeaturedBooksPaginationLoading extends FeaturedBooksState {
  final List<BookEntity> books;

  FeaturedBooksPaginationLoading({required this.books});
}

class FeaturedBooksSuccess extends FeaturedBooksState {
  final List<BookEntity> books;

  FeaturedBooksSuccess({required this.books});
}

class FeaturedBooksFailure extends FeaturedBooksState {
  final String errorMessage;

  FeaturedBooksFailure({required this.errorMessage});
}

class FeaturedBooksPaginationFailure extends FeaturedBooksState {
  final String errorMessage;
  final List<BookEntity> books;
  FeaturedBooksPaginationFailure(
      {required this.errorMessage, required this.books});
}
