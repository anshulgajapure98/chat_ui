import 'dart:developer';

import 'package:dio/dio.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late Dio dio;

  factory DioClient() => _instance;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://api.example.com/",
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );

    _addInterceptors();
  }

  // ================= INTERCEPTORS =================
  void _addInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // 🔐 Add token dynamically
          final token = await _getToken();
          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }

          log("➡️ REQUEST: ${options.method} ${options.path}");
          log("Headers: ${options.headers}");
          log("Query: ${options.queryParameters}");
          log("Body: ${options.data}");

          return handler.next(options);
        },
        onResponse: (response, handler) {
          log(
            "✅ RESPONSE: ${response.statusCode} ${response.requestOptions.path}",
          );
          log("Data: ${response.data}");
          return handler.next(response);
        },
        onError: (error, handler) {
          log("❌ ERROR: ${error.message}");
          log("Response: ${error.response?.data}");
          return handler.next(error);
        },
      ),
    );
  }

  // 🔐 Replace with secure storage (shared_pref / flutter_secure_storage)
  Future<String?> _getToken() async {
    return null; // TODO: return your token here
  }
}

class ApiResponse<T> {
  final T data;
  final int statusCode;

  ApiResponse({required this.data, required this.statusCode});
}
