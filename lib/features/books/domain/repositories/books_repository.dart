import 'package:bookly/core/error/failures.dart';
import 'package:bookly/features/books/domain/entities/book_entity.dart';
import 'package:dartz/dartz.dart';

abstract class BooksRepository {
  Future<Either<Failure, List<BookEntity>>> getFeaturedBooks(
      {int pageNumber = 0});
  Future<Either<Failure, List<BookEntity>>> getNewestBooks(
      {int pageNumber = 0});
}
