import 'package:dio/dio.dart';
import 'package:flock_pilot/shared/models/auth_response_model.dart';
import 'package:flock_pilot/shared/models/user_model.dart';

class AuthApi {
  final Dio dio;

  AuthApi(this.dio);

  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    final res = await dio.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );

    return AuthResponseModel.fromJson(res.data);
  }

  Future<AuthResponseModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final res = await dio.post(
      '/auth/register',
      data: {'name': name, 'email': email, 'password': password},
    );

    return AuthResponseModel.fromJson(res.data);
  }

  Future<UserModel> me() async {
    final res = await dio.get('/auth/me');
    return UserModel.fromJson(res.data);
  }

  Future<void> logout() async {
    await dio.post('/auth/logout');
  }
}
