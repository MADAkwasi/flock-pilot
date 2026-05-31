import 'package:flock_pilot/core/api/auth_api.dart';
import 'package:flock_pilot/shared/models/auth_response_model.dart';
import 'package:flock_pilot/shared/models/user_model.dart';
import 'package:flock_pilot/shared/utils/token_storage.dart';

class AuthRepository {
  final AuthApi api;
  final TokenStorage storage;

  AuthRepository(this.api, this.storage);

  Future<AuthResponseModel> login(String email, String password) async {
    final res = await api.login(email: email, password: password);

    await storage.saveToken(res.token);

    return res;
  }

  Future<AuthResponseModel> register(
    String name,
    String email,
    String password,
  ) async {
    final res = await api.register(
      name: name,
      email: email,
      password: password,
    );

    await storage.saveToken(res.token);

    return res;
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      final res = await api.me();
      return res;
    } catch (_) {
      return null;
    }
  }

  Future<void> logout() async {
    await api.logout();
    await storage.clearToken();
  }
}
