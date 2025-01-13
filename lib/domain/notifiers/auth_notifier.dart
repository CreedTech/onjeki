import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onjeki/data/local_storage/secure_storage_service.dart';
import 'package:onjeki/domain/repository/auth_repository.dart';

import '../states/auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final SecureStorageService _secureStorageService;
  final AuthRepository _authRepository;

  AuthNotifier(
    this._secureStorageService,
    this._authRepository,
  ) : super(const AuthState());

  // Check if user is already authenticated on app init
  Future<void> initializeAuth() async {
    final token = await _secureStorageService.getToken();
    if (token != null) {
      state = state.copyWith(isAuthenticated: true);
    } else {
      state = state.copyWith(isAuthenticated: false);
    }
  }

  Future<void> login(String email) async {
    state = state.copyWith(
        isLoading: true, errorMessage: null, successMessage: null);
    try {
      final response = await _authRepository.login(email);

      // Extract token from response
      final token = response['token'];
      // save token to secure storage
      await _secureStorageService.saveToken(token);

      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        successMessage: 'Login successful',
        errorMessage: null,
      );
    } catch (e) {
      print(e);
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        errorMessage: 'Login failed: ${e.toString()}',
        successMessage: null,
      );
    }
  }

  Future<void> logout() async {
    state = state.copyWith(
        isLoading: true, errorMessage: null, successMessage: null);
    try {
      // Clear token from secure storage
      await _secureStorageService.deleteToken();
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        successMessage: 'Logout successful',
        errorMessage: null,
      );
    } catch (e) {
      print(e);
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        errorMessage: 'Logout failed: ${e.toString()}',
        successMessage: null,
      );
    }
  }
}
