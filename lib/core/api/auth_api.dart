import 'package:dio/dio.dart';
import 'package:flock_pilot/core/api/api_exception.dart';
import 'package:flock_pilot/shared/models/auth_response_model.dart';
import 'package:flock_pilot/shared/models/user_model.dart';

class AuthApi {
  final Dio dio;

  AuthApi(this.dio);

  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      final data = res.data;

      if (data['token'] == null) {
        throw throw ApiException(message: data['message'] ?? 'Login failed');
      }

      return AuthResponseModel.fromJson(data);
    } on DioException catch (e) {
      throw throw ApiException(
        message: e.response?.data['message'] ?? 'Login failed',
      );
    }
  }

  Future<AuthResponseModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final res = await dio.post(
        '/auth/signup',
        data: {'name': name, 'email': email, 'password': password},
      );

      final data = res.data;

      if (data['token'] == null) {
        throw throw ApiException(
          message: data['message'] ?? 'Registration failed',
        );
      }

      return AuthResponseModel.fromJson(res.data);
    } on DioException catch (e) {
      throw ApiException(
        message: e.response?.data['message'] ?? 'Registration failed',
      );
    }
  }

  Future<UserModel> me() async {
    final res = await dio.get('/auth/me');

    return UserModel.fromJson(res.data['data']['user']);
  }

  Future<void> logout() async {
    try {
      await dio.post('/auth/logout');
    } on DioException catch (e) {
      throw ApiException(
        message: e.response?.data['message'] ?? 'Logout failed',
      );
    }
  }
}
