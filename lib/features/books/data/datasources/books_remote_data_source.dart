import 'package:bookly/core/error/exceptions.dart';
import 'package:bookly/features/books/data/models/book_model/book_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/api/api_constants.dart';
import '../../../../core/api/api_service.dart';

abstract class BooksRemoteDataSource {
  Future<List<BookModel>> getFeaturedBooks({int pageNumber = 0});
  Future<List<BookModel>> getNewestBooks({int pageNumber = 0});
}

class BooksRemoteDataSourceImpl implements BooksRemoteDataSource {
  final ApiService apiService;

  const BooksRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<BookModel>> getFeaturedBooks({int pageNumber = 0}) async {
    return getBooks(
        orderBy: ApiConstants.orderRelevance, pageNumber: pageNumber);
  }

  @override
  Future<List<BookModel>> getNewestBooks({int pageNumber = 0}) async {
    return getBooks(orderBy: ApiConstants.orderNewest, pageNumber: pageNumber);
  }

  Future<List<BookModel>> getBooks(
      {required String orderBy, int pageNumber = 0}) async {
    final startIndex = pageNumber * 10;
    final response = await apiService.getVolumes(
        query: 'programming',
        filter: ApiConstants.filterFreeEbooks,
        maxResults: ApiConstants.defaultMaxResults,
        orderBy: orderBy,
        startIndex: startIndex);

    return processResponse(response);
  }

  List<BookModel> processResponse(Response response) {
    if (response.statusCode == 200) {
      final data = response.data as Map<String, dynamic>;
      final items = data['items'] as List<dynamic>?;

      if (items == null || items.isEmpty) return [];

      return items
          .map((json) => BookModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(
        statusCode: response.statusCode ?? 0,
        responseData: response.data,
      );
    }
  }
}
