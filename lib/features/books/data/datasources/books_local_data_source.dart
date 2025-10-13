import 'package:bookly/features/books/data/models/book_model/book_model.dart';

abstract class BooksLocalDataSource {
  Future<void> cacheNewestBooks(List<BookModel> books);
  Future<void> cacheFeaturedBooks(List<BookModel> books);
  Future<List<BookModel>> getCachedFeaturedBooks();
  Future<List<BookModel>> getCachedNewestBooks();
}

class BooksLocalDataSourceImpl implements BooksLocalDataSource {
  @override
  Future<void> cacheFeaturedBooks(List<BookModel> books) {
    // TODO: implement cacheFeaturedBooks
    throw UnimplementedError();
  }

  @override
  Future<void> cacheNewestBooks(List<BookModel> books) {
    // TODO: implement cacheNewestBooks
    throw UnimplementedError();
  }

  @override
  Future<List<BookModel>> getCachedFeaturedBooks() {
    // TODO: implement getCachedFeaturedBooks
    throw UnimplementedError();
  }

  @override
  Future<List<BookModel>> getCachedNewestBooks() {
    // TODO: implement getCachedNewestBooks
    throw UnimplementedError();
  }
}
