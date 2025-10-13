import 'package:bookly/features/books/data/models/book_model/access_info.dart';
import 'package:bookly/features/books/data/models/book_model/book_model.dart';
import 'package:bookly/features/books/data/models/book_model/epub.dart';
import 'package:bookly/features/books/data/models/book_model/image_links.dart';
import 'package:bookly/features/books/data/models/book_model/industry_identifier.dart';
import 'package:bookly/features/books/data/models/book_model/panelization_summary.dart';
import 'package:bookly/features/books/data/models/book_model/pdf.dart';
import 'package:bookly/features/books/data/models/book_model/reading_modes.dart';
import 'package:bookly/features/books/data/models/book_model/sale_info.dart';
import 'package:bookly/features/books/data/models/book_model/volume_info.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  static const String featuredBooksBoxName = 'featured_books_box';
  static const String newestBooksBoxName = 'newest_books_box';

  static Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive
        ..registerAdapter(BookModelAdapter())
        ..registerAdapter(VolumeInfoAdapter())
        ..registerAdapter(ImageLinksAdapter())
        ..registerAdapter(SaleInfoAdapter())
        ..registerAdapter(AccessInfoAdapter())
        ..registerAdapter(IndustryIdentifierAdapter())
        ..registerAdapter(PanelizationSummaryAdapter())
        ..registerAdapter(ReadingModesAdapter())
        ..registerAdapter(EpubAdapter())
        ..registerAdapter(PdfAdapter());
    }

    await Hive.openBox<BookModel>(featuredBooksBoxName);
    await Hive.openBox<BookModel>(newestBooksBoxName);
  }

  static Box<BookModel> get featuredBooksBox =>
      Hive.box<BookModel>(featuredBooksBoxName);
  static Box<BookModel> get newestBooksBox =>
      Hive.box<BookModel>(newestBooksBoxName);
}
