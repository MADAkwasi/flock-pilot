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

  Future<void> updateExpense({
    required String farmId,
    required String expenseId,
    required Map<String, dynamic> payload,
  }) async {
    final response = await dio.patch(
      "/expenses/$farmId/expense/$expenseId",
      data: payload,
    );

    if (response.statusCode != 200) {
      throw ApiException(
        message: response.data['message'] ?? 'Failed to update expense',
      );
    }
  }

  Future<void> deleteExpense({
    required String farmId,
    required String expenseId,
  }) async {
    final response = await dio.delete("/expenses/$farmId/expense/$expenseId");

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw ApiException(
        message: response.data['message'] ?? 'Failed to delete expense',
      );
    }
  }
}
