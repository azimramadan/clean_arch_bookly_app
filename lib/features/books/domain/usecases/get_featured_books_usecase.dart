import 'package:bookly/core/error/failures.dart';
import 'package:bookly/core/usecases/usecase.dart';
import 'package:bookly/features/books/domain/entities/book_entity.dart';
import 'package:bookly/features/books/domain/repositories/books_repository.dart';
import 'package:dartz/dartz.dart';

class GetFeaturedBooksUseCase extends UseCase<List<BookEntity>, NoParams> {
  final BooksRepository booksRepository;

  GetFeaturedBooksUseCase({required this.booksRepository});

  @override
  Future<Either<Failure, List<BookEntity>>> call(NoParams params) async {
    return await booksRepository.getFeaturedBooks();
  }
}
