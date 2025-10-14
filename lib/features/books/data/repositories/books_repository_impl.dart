import 'package:bookly/core/error/exceptions.dart';
import 'package:bookly/core/error/failures.dart';
import 'package:bookly/features/books/data/datasources/books_local_data_source.dart';
import 'package:bookly/features/books/data/datasources/books_remote_data_source.dart';
import 'package:bookly/features/books/domain/entities/book_entity.dart';
import 'package:bookly/features/books/domain/repositories/books_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class BooksRepositoryImpl implements BooksRepository {
  final BooksRemoteDataSource remoteDataSource;
  final BooksLocalDataSource localDataSource;

  BooksRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<BookEntity>>> getFeaturedBooks() async {
    try {
      final remoteBooks = await remoteDataSource.getFeaturedBooks();
      await localDataSource.cacheFeaturedBooks(remoteBooks);
      return Right(remoteBooks.cast<BookEntity>());
    } on DioException catch (e) {
      var message = ServerFailure.fromDioError(e).message;
      return await getFeaturedBooksFromCache(
        errorMessage: 'ServerFailure: $message',
      );
    } on ServerException catch (e) {
      var message = ServerFailure.fromResponse(
        response: e.responseData,
        statusCode: e.statusCode,
      ).message;
      return await getFeaturedBooksFromCache(
        errorMessage: 'ServerFailure: $message',
      );
    } catch (e) {
      return await getFeaturedBooksFromCache(
        errorMessage: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getNewestBooks() async {
    try {
      final remoteBooks = await remoteDataSource.getNewestBooks();
      await localDataSource.cacheNewestBooks(remoteBooks);
      return Right(remoteBooks.cast<BookEntity>());
    } on DioException catch (e) {
      var message = ServerFailure.fromDioError(e).message;
      return await getNewestBooksFromCache(
        errorMessage: 'ServerFailure: $message',
      );
    } on ServerException catch (e) {
      var message = ServerFailure.fromResponse(
        response: e.responseData,
        statusCode: e.statusCode,
      ).message;
      return await getNewestBooksFromCache(
        errorMessage: 'ServerFailure: $message',
      );
    } catch (e) {
      return await getNewestBooksFromCache(
        errorMessage: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  Future<Either<Failure, List<BookEntity>>> getFeaturedBooksFromCache(
      {required String errorMessage}) async {
    try {
      final cachedBooks = await localDataSource.getCachedFeaturedBooks();
      if (cachedBooks.isEmpty) {
        return Left(
            CacheFailure(message: 'No cached data available. $errorMessage'));
      }
      return Right(cachedBooks.cast<BookEntity>());
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<BookEntity>>> getNewestBooksFromCache(
      {required String errorMessage}) async {
    try {
      final cachedBooks = await localDataSource.getCachedNewestBooks();
      if (cachedBooks.isEmpty) {
        return Left(
            CacheFailure(message: 'No cached data available. $errorMessage'));
      }
      return Right(cachedBooks.cast<BookEntity>());
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
