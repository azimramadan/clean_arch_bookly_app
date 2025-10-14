import 'package:dio/dio.dart';

abstract class Failure {
  final String message;
  const Failure({required this.message});
}

class CacheFailure extends Failure {
  const CacheFailure({required String message}) : super(message: message);
}

class ServerFailure extends Failure {
  ServerFailure({required super.message});

  factory ServerFailure.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          message:
              '⏱️ Connection to the server timed out. Please try again later.',
        );

      case DioExceptionType.sendTimeout:
        return ServerFailure(
          message: '🚫 Request took too long to send. Please try again.',
        );

      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          message: '📭 Server took too long to respond. Check your connection.',
        );

      case DioExceptionType.badCertificate:
        return ServerFailure(
          message:
              '⚠️ Invalid SSL certificate from the server. Please try again later.',
        );

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final data = e.response?.data;
        if (statusCode != null) {
          return ServerFailure.fromResponse(statusCode, data);
        }
        return ServerFailure(
          message: '📡 The server returned an invalid response.',
        );

      case DioExceptionType.cancel:
        return ServerFailure(
          message:
              '❌ Request was cancelled before completion. Please try again.',
        );

      case DioExceptionType.connectionError:
        return ServerFailure(
          message:
              '🌐 No internet connection. Please check your network and try again.',
        );

      case DioExceptionType.unknown:
      default:
        return ServerFailure(
          message:
              '⚙️ An unexpected error occurred while contacting the server. Please try again.',
        );
    }
  }

  factory ServerFailure.fromResponse(
      {required int statusCode, required dynamic response}) {
    final message = _extractErrorMessage(response);

    if (statusCode >= 500) {
      return ServerFailure(
        message:
            '💥 Server is currently unavailable (Error $statusCode). Please try again later.',
      );
    } else if (statusCode == 404) {
      return ServerFailure(
        message: '🔍 The requested resource could not be found (Error 404).',
      );
    } else if (statusCode == 401) {
      return ServerFailure(
        message: '🔒 Unauthorized access. Please log in again.',
      );
    } else if (statusCode == 403) {
      return ServerFailure(
        message:
            '🚫 Access denied. You do not have permission to perform this action.',
      );
    } else if (statusCode == 400) {
      return ServerFailure(
        message:
            message ?? '⚠️ Bad request. Please check your input and try again.',
      );
    } else {
      return ServerFailure(
        message:
            message ?? '⚙️ An unknown error occurred. Please try again later.',
      );
    }
  }

  static String? _extractErrorMessage(dynamic response) {
    try {
      if (response is Map<String, dynamic>) {
        if (response.containsKey('error')) {
          final error = response['error'];
          if (error is Map<String, dynamic> && error.containsKey('message')) {
            return error['message'] as String?;
          } else if (error is String) {
            return error;
          }
        } else if (response.containsKey('message')) {
          return response['message'] as String?;
        }
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
