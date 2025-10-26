part of 'newest_books_cubit.dart';

@immutable
sealed class NewestBooksState {}

final class NewestBooksInitial extends NewestBooksState {}

class NewestBooksLoading extends NewestBooksState {}

class NewestBooksPaginationLoading extends NewestBooksState {
  final List<BookEntity> newestBooks;

  NewestBooksPaginationLoading({required this.newestBooks});
}

class NewestBooksSuccess extends NewestBooksState {
  final List<BookEntity> newestBooks;

  NewestBooksSuccess({required this.newestBooks});
}

class NewestBooksFailure extends NewestBooksState {
  final String errorMessage;

  NewestBooksFailure({required this.errorMessage});
}

class NewestBooksPaginationFailure extends NewestBooksState {
  final String errorMessage;
  final List<BookEntity> newestBooks;
  NewestBooksPaginationFailure(
      {required this.errorMessage, required this.newestBooks});
}
