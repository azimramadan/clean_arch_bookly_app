import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://www.googleapis.com/books/v1';

  static const String volumes = '/volumes';

  static const String queryKey = 'q';
  static const String filterKey = 'filter';
  static const String orderByKey = 'orderBy';
  static const String maxResultsKey = 'maxResults';
  static const String startIndexKey = 'startIndex';
  static const String apiKeyParam = 'key';

  static const String filterFreeEbooks = 'free-ebooks';
  static const String filterPaidEbooks = 'paid-ebooks';
  static const String filterEbooks = 'ebooks';

  static const String orderNewest = 'newest';
  static const String orderRelevance = 'relevance';

  static const int defaultMaxResults = 40;
  static const int defaultStartIndex = 0;

  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  static String get apiKey => dotenv.env['GOOGLE_BOOKS_API_KEY'] ?? '';
  static bool get hasApiKey => apiKey.isNotEmpty;
}
