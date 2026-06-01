import 'package:dio/dio.dart';
import 'package:flock_pilot/shared/utils/token_storage.dart';

class ApiClient {
  static late final Dio dio;

  static void init(TokenStorage storage) {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://10.0.2.2:8000/api/v1',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await storage.getToken();

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
      ),
    );
  }
}
