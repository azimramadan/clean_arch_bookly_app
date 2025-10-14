import 'package:dio/dio.dart';

import 'api_constants.dart';

abstract class ApiService {
  Future<Response> getVolumes({
    required String query,
    String? filter,
    int? maxResults,
    String? orderBy,
    int? startIndex,
  });
}

class ApiServiceImpl implements ApiService {
  final Dio dio;

  const ApiServiceImpl({required this.dio});

  @override
  Future<Response> getVolumes({
    required String query,
    String? filter,
    int? maxResults,
    String? orderBy,
    int? startIndex,
  }) async {
    final response = await dio.get(
      ApiConstants.volumes,
      queryParameters: {
        ApiConstants.queryKey: query,
        if (filter != null) ApiConstants.filterKey: filter,
        ApiConstants.maxResultsKey:
            maxResults ?? ApiConstants.defaultMaxResults,
        if (orderBy != null) ApiConstants.orderByKey: orderBy,
        if (startIndex != null) ApiConstants.startIndexKey: startIndex,
      },
    );

    return response;
  }
}
