import 'package:chat_ui/network/api_exception.dart';
import 'package:chat_ui/network/dio_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

typedef FromJson<T> = T Function(dynamic json);

class ApiService {
  final Dio _dio = DioClient().dio;

  Future<Either<ApiException, ApiResponse<T>>> _request<T>({
    required String method,
    required String path,
    FromJson<T>? fromJson,
    dynamic data,
    Map<String, dynamic>? queryParams,
    Options? options,
  }) async {
    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParams,
        options: (options ?? Options()).copyWith(method: method),
      );

      final statusCode = response.statusCode ?? 0;
      if (statusCode >= 200 && statusCode < 300) {
        final responseData = response.data;
        if (responseData == null) {
          return Left(ApiException(message: "Empty response from server"));
        }
        if (fromJson != null) {
          try {
            final parsedData = fromJson(responseData);
            return Right(ApiResponse(data: parsedData, statusCode: statusCode));
          } catch (e) {
            return Left(
              ApiException(message: "Parsing error: ${e.toString()}"),
            );
          }
        }
        return Right(ApiResponse(data: responseData, statusCode: statusCode));
      } else {
        return Left(
          ApiException(
            message:
                response.data?["message"] ??
                "Request failed (${response.statusCode})",
            statusCode: response.statusCode,
            error: response.data,
          ),
        );
      }
    } on DioException catch (e) {
      return Left(ApiException.fromDioError(e));
    } catch (e) {
      return Left(ApiException(message: "Unexpected error: ${e.toString()}"));
    }
  }

  Future<Either<ApiException, ApiResponse<T>>> get<T>(
    String path, {
    FromJson<T>? fromJson,
    Map<String, dynamic>? queryParams,
    Options? options,
  }) {
    return _request(
      method: "GET",
      path: path,
      fromJson: fromJson,
      queryParams: queryParams,
      options: options,
    );
  }

  Future<Either<ApiException, ApiResponse<T>>> post<T>(
    String path, {
    FromJson<T>? fromJson,
    dynamic data,
    Map<String, dynamic>? queryParams,
    Options? options,
  }) {
    return _request(
      method: "POST",
      path: path,
      data: data,
      fromJson: fromJson,
      queryParams: queryParams,
      options: options,
    );
  }

  Future<Either<ApiException, ApiResponse<T>>> put<T>(
    String path, {
    FromJson<T>? fromJson,
    dynamic data,
    Map<String, dynamic>? queryParams,
    Options? options,
  }) {
    return _request(
      method: "PUT",
      path: path,
      data: data,
      fromJson: fromJson,
      queryParams: queryParams,
      options: options,
    );
  }

  Future<Either<ApiException, ApiResponse<T>>> delete<T>(
    String path, {
    FromJson<T>? fromJson,
    dynamic data,
    Map<String, dynamic>? queryParams,
    Options? options,
  }) {
    return _request(
      method: "DELETE",
      path: path,
      data: data,
      fromJson: fromJson,
      queryParams: queryParams,
      options: options,
    );
  }
}
