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
  Future<Either<Failure, List<BookEntity>>> getFeaturedBooks(
      {int pageNumber = 0}) async {
    final cachedResult =
        await getFeaturedBooksFromCache(pageNumber: pageNumber);
    return cachedResult.fold(
      (failure) async {
        try {
          final remoteBooks =
              await remoteDataSource.getFeaturedBooks(pageNumber: pageNumber);
          await localDataSource.cacheFeaturedBooks(remoteBooks);
          return Right(remoteBooks.cast<BookEntity>());
        } on DioException catch (e) {
          return left(ServerFailure.fromDioError(e));
        } on ServerException catch (e) {
          return left(ServerFailure.fromResponse(
            response: e.responseData,
            statusCode: e.statusCode,
          ));
        } catch (e) {
          return left(ServerFailure(message: e.toString()));
        }
      },
      (cachedBooks) => Right(cachedBooks),
    );
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getNewestBooks(
      {int pageNumber = 0}) async {
    final cachedResult = await getNewestBooksFromCache(pageNumber: pageNumber);
    return cachedResult.fold(
      (failure) async {
        try {
          final remoteBooks =
              await remoteDataSource.getNewestBooks(pageNumber: pageNumber);
          await localDataSource.cacheNewestBooks(remoteBooks);
          return Right(remoteBooks.cast<BookEntity>());
        } on DioException catch (e) {
          return left(ServerFailure.fromDioError(e));
        } on ServerException catch (e) {
          return left(ServerFailure.fromResponse(
            response: e.responseData,
            statusCode: e.statusCode,
          ));
        } catch (e) {
          return left(ServerFailure(message: e.toString()));
        }
      },
      (cachedBooks) => Right(cachedBooks),
    );
  }

  Future<Either<Failure, List<BookEntity>>> getFeaturedBooksFromCache(
      {int pageNumber = 0}) async {
    try {
      final cachedBooks =
          await localDataSource.getCachedFeaturedBooks(pageNumber: pageNumber);
      if (cachedBooks.isEmpty) {
        return const Left(CacheFailure(message: 'No cached data available.'));
      }
      return Right(cachedBooks.cast<BookEntity>());
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<BookEntity>>> getNewestBooksFromCache(
      {int pageNumber = 0}) async {
    try {
      final cachedBooks =
          await localDataSource.getCachedNewestBooks(pageNumber: pageNumber);
      if (cachedBooks.isEmpty) {
        return const Left(CacheFailure(message: 'No cached data available.'));
      }
      return Right(cachedBooks.cast<BookEntity>());
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
