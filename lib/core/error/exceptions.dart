class ServerException implements Exception {
  final int statusCode;
  final dynamic responseData;

  const ServerException({
    required this.statusCode,
    required this.responseData,
  });

  @override
  String toString() => 'ServerException($statusCode): $responseData';
}
