import 'package:bookly/core/error/exceptions.dart';
import 'package:bookly/features/books/data/models/book_model/book_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/api/api_constants.dart';
import '../../../../core/api/api_service.dart';

abstract class BooksRemoteDataSource {
  Future<List<BookModel>> getFeaturedBooks();
  Future<List<BookModel>> getNewestBooks();
}

class BooksRemoteDataSourceImpl implements BooksRemoteDataSource {
  final ApiService apiService;

  const BooksRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<BookModel>> getFeaturedBooks() async {
    return getBooks(orderBy: ApiConstants.orderRelevance);
  }

  @override
  Future<List<BookModel>> getNewestBooks() async {
    return getBooks(orderBy: ApiConstants.orderNewest);
  }

  Future<List<BookModel>> getBooks({required String orderBy}) async {
    final response = await apiService.getVolumes(
      query: 'programming',
      filter: ApiConstants.filterFreeEbooks,
      maxResults: ApiConstants.defaultMaxResults,
      orderBy: orderBy,
    );

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
