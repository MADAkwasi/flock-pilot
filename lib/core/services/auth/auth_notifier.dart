import 'package:flock_pilot/core/api/api_exception.dart';
import 'package:flock_pilot/data/auth_repository.dart';
import 'package:flock_pilot/state/auth_state.dart';
import 'package:flutter_riverpod/legacy.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repo;

  AuthNotifier(this._repo) : super(AuthState());

  Future<void> login({required String email, required String password}) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final res = await _repo.login(email, password);

      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        user: res.user,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        user: null,
        error: e is ApiException ? e.message : e.toString(),
      );
    }
  }

  Future<void> register(String name, String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final res = await _repo.register(name, email, password);

      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        user: res.user,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        user: null,
        error: e is ApiException ? e.message : e.toString(),
      );
    }
  }

  Future<void> logout() async {
    await _repo.logout();

    state = AuthState(isAuthenticated: false, user: null, isLoading: false);
  }
}
