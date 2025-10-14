import 'package:bookly/core/utils/helpers/hive_helper.dart';
import 'package:bookly/features/books/data/models/book_model/book_model.dart';

abstract class BooksLocalDataSource {
  Future<void> cacheNewestBooks(List<BookModel> books);
  Future<void> cacheFeaturedBooks(List<BookModel> books);
  Future<List<BookModel>> getCachedFeaturedBooks();
  Future<List<BookModel>> getCachedNewestBooks();
}

class BooksLocalDataSourceImpl implements BooksLocalDataSource {
  const BooksLocalDataSourceImpl();

  @override
  Future<void> cacheFeaturedBooks(List<BookModel> books) async {
    final box = HiveHelper.featuredBooksBox;

    for (final book in books) {
      if (book.bookId.isEmpty) continue;
      await box.put(book.bookId, book);
    }
  }

  @override
  Future<void> cacheNewestBooks(List<BookModel> books) async {
    final box = HiveHelper.newestBooksBox;

    for (final book in books) {
      if (book.bookId.isEmpty) continue;
      await box.put(book.bookId, book);
    }
  }

  @override
  Future<List<BookModel>> getCachedFeaturedBooks() async {
    final box = HiveHelper.featuredBooksBox;

    if (box.isEmpty) return const [];

    return box.values.toList();
  }

  @override
  Future<List<BookModel>> getCachedNewestBooks() async {
    final box = HiveHelper.newestBooksBox;

    if (box.isEmpty) return const [];

    return box.values.toList();
  }
}
