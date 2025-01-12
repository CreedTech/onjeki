import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onjeki/data/local_storage/secure_storage_service.dart';
import 'package:onjeki/data/services/api_services.dart';
import 'package:onjeki/domain/repository/auth_repository.dart';

import '../notifiers/auth_notifier.dart';
import '../states/auth_state.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});
final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return AuthRepository(apiService);
});
final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final secureStorageService = ref.read(secureStorageServiceProvider);
  final authRepository = ref.read(authRepositoryProvider);
  return AuthNotifier(secureStorageService, authRepository);
});
