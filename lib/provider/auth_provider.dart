import 'package:flock_pilot/core/api/api_client.dart';
import 'package:flock_pilot/core/api/auth_api.dart';
import 'package:flock_pilot/core/services/auth/auth_notifier.dart';
import 'package:flock_pilot/data/auth_repository.dart';
import 'package:flock_pilot/shared/utils/token_storage.dart';
import 'package:flock_pilot/state/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/legacy.dart';

final dioProvider = Provider<Dio>((ref) {
  return ApiClient.dio;
});

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  return TokenStorage();
});

final authApiProvider = Provider<AuthApi>((ref) {
  return AuthApi(ref.read(dioProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.read(authApiProvider),
    ref.read(tokenStorageProvider),
  );
});

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read(authRepositoryProvider));
});
