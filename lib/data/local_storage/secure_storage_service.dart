import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // keys for storage
  static const String _authTokenKey = 'auth_token';

  // Save token to secure storage
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _authTokenKey, value: token);
  }

  // Get token from secure storage
  Future<String?> getToken() async {
    return await _secureStorage.read(key: _authTokenKey);
  }
  // remove token from secure storage
  Future<void> deleteToken() async {
    await _secureStorage.delete(key: _authTokenKey);
  }

  // clear all secure storage
  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }
}