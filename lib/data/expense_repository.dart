import 'package:flock_pilot/core/api/expense_api.dart';

class ExpenseRepository {
  final ExpenseApi api;

  ExpenseRepository(this.api);

  Future<void> createExpense({
    required String farmId,
    required Map<String, dynamic> payload,
  }) {
    return api.createExpense(farmId: farmId, payload: payload);
  }
}
