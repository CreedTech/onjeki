import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:onjeki/core/utils/app_constants.dart'; // To securely store tokens

class ApiService {
  final Dio _dio;
  final FlutterSecureStorage _secureStorage =
      const FlutterSecureStorage(); // For secure token storage

  // Base URL for your API
  final String _baseUrl = AppConstants.BASE_URL;

  ApiService({Dio? dio}) : _dio = dio ?? Dio() {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // Add interceptors for token addition and error handling
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add token to the request if available
        final token = await _secureStorage.read(key: 'auth_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options); // Continue with the request
      },
      onResponse: (response, handler) {
        // Handle any global response modifications here if necessary
        return handler
            .next(response); // Pass the response to the calling function
      },
      onError: (DioException error, handler) {
        // Global error handling
        _handleError(error);
        return handler.next(error); // Pass the error to the calling function
      },
    ));
  }

  // GET Request
  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await _dio.get(endpoint, queryParameters: queryParameters);
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // POST Request
  Future<Response> post(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // PUT Request
  Future<Response> put(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // DELETE Request
  Future<Response> delete(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.delete(endpoint, data: data);
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Token Handling
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: 'auth_token', value: token);
  }

  Future<void> clearToken() async {
    await _secureStorage.delete(key: 'auth_token');
  }

  // Error Handling
  Exception _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return Exception('Connection timeout. Please try again.');
        case DioExceptionType.sendTimeout:
          return Exception('Request timeout. Please try again.');
        case DioExceptionType.receiveTimeout:
          return Exception('Server response timeout. Please try again.');
        case DioExceptionType.badResponse:
          // Handle specific status codes
          final statusCode = error.response?.statusCode;
          final message =
              error.response?.data['message'] ?? 'An error occurred';
          if (statusCode == 401) {
            return Exception('Unauthorized: $message');
          } else if (statusCode == 403) {
            return Exception('Forbidden: $message');
          } else if (statusCode == 404) {
            return Exception('Not Found: $message');
          }
          return Exception('Error $statusCode: $message');
        case DioExceptionType.cancel:
          return Exception('Request was cancelled.');
        default:
          return Exception('Unexpected error: ${error.message}');
      }
    }
    return Exception('An unexpected error occurred.');
  }
}
