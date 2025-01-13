import 'package:onjeki/data/services/api_services.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository(this._apiService);

  Future<Map<String, dynamic>> login(String email) async {
    try {
      final response = await _apiService.post(
        '/login',
        data: {
          'email': email,
        },
      );
      return response.data;
    } catch (e) {
      // rethrow;
      throw Exception('Login failed: ${e.toString()} ');
    }
  }
}
