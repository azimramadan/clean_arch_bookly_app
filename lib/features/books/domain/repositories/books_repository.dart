import 'package:bookly/core/error/failures.dart';
import 'package:bookly/features/books/domain/entities/book_entity.dart';
import 'package:dartz/dartz.dart';

abstract class BooksRepository {
  Future<Either<Failure, List<BookEntity>>> getFeaturedBooks();
  Future<Either<Failure, List<BookEntity>>> getNewestBooks();
}
