import 'package:dio/dio.dart';

import 'api_constants.dart';

class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      // connectTimeout: ApiConstants.connectTimeout,
      // receiveTimeout: ApiConstants.receiveTimeout,
      // sendTimeout: ApiConstants.sendTimeout,
    ));
  }
  Future<Response> getVolumes({
    required String query,
    String? filter,
    int? maxResults,
    String? orderBy,
    int? startIndex,
  }) async {
    if (!ApiConstants.hasApiKey) {
      throw Exception('API Key is missing. Please add it to .env file');
    }
    final response = await _dio.get(
      ApiConstants.volumes,
      queryParameters: {
        ApiConstants.queryKey: query,
        if (filter != null) ApiConstants.filterKey: filter,
        ApiConstants.maxResultsKey:
            maxResults ?? ApiConstants.defaultMaxResults,
        if (orderBy != null) ApiConstants.orderByKey: orderBy,
        if (startIndex != null) ApiConstants.startIndexKey: startIndex,
        ApiConstants.apiKeyParam: ApiConstants.apiKey,
      },
    );

    return response;
  }
}
