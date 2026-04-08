import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic error;

  ApiException({required this.message, this.statusCode, this.error});

  // 🔥 Factory for Dio errors
  factory ApiException.fromDioError(dynamic e) {
    if (e is! Exception) {
      return ApiException(message: "Unknown error");
    }

    try {
      if (e is DioException) {
        switch (e.type) {
          case DioExceptionType.connectionTimeout:
            return ApiException(message: "Connection timeout");

          case DioExceptionType.sendTimeout:
            return ApiException(message: "Send timeout");

          case DioExceptionType.receiveTimeout:
            return ApiException(message: "Receive timeout");

          case DioExceptionType.badResponse:
            final data = e.response?.data;

            return ApiException(
              message:
                  data?["message"] ??
                  data?["error"] ??
                  "Server error (${e.response?.statusCode})",
              statusCode: e.response?.statusCode,
              error: data,
            );

          case DioExceptionType.cancel:
            return ApiException(message: "Request cancelled");

          case DioExceptionType.connectionError:
            return ApiException(message: "No internet connection");

          case DioExceptionType.unknown:
          default:
            return ApiException(message: e.message ?? "Unexpected error");
        }
      }
    } catch (_) {
      return ApiException(message: "Unexpected error");
    }

    return ApiException(message: "Something went wrong");
  }

  @override
  String toString() =>
      "ApiException(message: $message, statusCode: $statusCode)";
}
