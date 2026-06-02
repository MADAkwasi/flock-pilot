import 'package:flock_pilot/core/api/api_exception.dart';
import 'package:flock_pilot/data/auth_repository.dart';
import 'package:flock_pilot/provider/farm_provider.dart';
import 'package:flock_pilot/state/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repo;
  final Ref ref;

  AuthNotifier(this._repo, this.ref) : super(AuthState());

  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _repo.login(email, password);

      await bootstrap();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        user: null,
        error: e.toString(),
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

    ref.read(farmProvider.notifier).clearFarm();

    state = AuthState(isAuthenticated: false, user: null, isLoading: false);
  }

  Future<void> bootstrap() async {
    state = state.copyWith(isLoading: true);

    final token = await _repo.getStoredToken();

    if (token == null) {
      state = state.copyWith(
        isAuthenticated: false,
        isLoading: false,
        user: null,
      );
      return;
    }

    try {
      final user = await _repo.getCurrentUser();

      if (user == null) {
        state = state.copyWith(
          isAuthenticated: false,
          isLoading: false,
          user: null,
        );
        return;
      }

      state = state.copyWith(
        isAuthenticated: true,
        isLoading: false,
        user: user,
      );

      if (user.farms.isNotEmpty) {
        final farmId = user.farms.first.id;
        await ref.read(farmProvider.notifier).loadFarm(farmId);
      }
    } catch (_) {
      await _repo.logout();

      state = state.copyWith(
        isAuthenticated: false,
        isLoading: false,
        user: null,
      );
    }
  }
}
