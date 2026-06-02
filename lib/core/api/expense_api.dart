import 'package:dio/dio.dart';
import 'package:flock_pilot/core/api/api_exception.dart';

class ExpenseApi {
  final Dio dio;

  ExpenseApi(this.dio);

  Future<void> createExpense({
    required String farmId,
    required Map<String, dynamic> payload,
  }) async {
    try {
      await dio.post("/expenses/$farmId", data: payload);
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Failed to create expense';

      throw ApiException(message: message);
    }
  }
}
