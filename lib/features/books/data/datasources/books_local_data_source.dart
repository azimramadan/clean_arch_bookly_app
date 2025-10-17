import 'package:bookly/core/utils/helpers/hive_helper.dart';
import 'package:bookly/features/books/data/models/book_model/book_model.dart';

abstract class BooksLocalDataSource {
  Future<void> cacheNewestBooks(List<BookModel> books);
  Future<void> cacheFeaturedBooks(List<BookModel> books);
  Future<List<BookModel>> getCachedFeaturedBooks({int pageNumber = 0});
  Future<List<BookModel>> getCachedNewestBooks({int pageNumber = 0});
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
  Future<List<BookModel>> getCachedFeaturedBooks({int pageNumber = 0}) async {
    final box = HiveHelper.featuredBooksBox;

    if (box.isEmpty) return const [];
    final startIndex = pageNumber * 10;
    final endIndex = startIndex + 10;

    final cachedBooks = box.values.toList();
    if (startIndex >= cachedBooks.length) return const [];

    return cachedBooks.sublist(
      startIndex,
      endIndex > cachedBooks.length ? cachedBooks.length : endIndex,
    );
  }

  @override
  Future<List<BookModel>> getCachedNewestBooks({int pageNumber = 0}) async {
    final box = HiveHelper.newestBooksBox;

    if (box.isEmpty) return const [];
    final startIndex = pageNumber * 10;
    final endIndex = startIndex + 10;

    final cachedBooks = box.values.toList();
    if (startIndex >= cachedBooks.length) return const [];

    return cachedBooks.sublist(
      startIndex,
      endIndex > cachedBooks.length ? cachedBooks.length : endIndex,
    );
  }
}
