import 'package:flock_pilot/data/auth_repository.dart';
import 'package:flock_pilot/state/auth_state.dart';
import 'package:flutter_riverpod/legacy.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository repo;

  AuthNotifier(this.repo) : super(AuthState());

  Future<void> checkAuth() async {
    state = state.copyWith(isLoading: true);

    final user = await repo.getCurrentUser();

    if (user != null) {
      state = AuthState(isAuthenticated: true, user: user);
    } else {
      state = AuthState(isAuthenticated: false);
    }
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true);

    final result = await repo.login(email, password);

    state = AuthState(isAuthenticated: true, user: result.user);
  }

  Future<void> logout() async {
    await repo.logout();
    state = AuthState(isAuthenticated: false);
  }
}
