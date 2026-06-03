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

  Future<void> updateExpense({
    required String farmId,
    required String expenseId,
    required Map<String, dynamic> payload,
  }) {
    return api.updateExpense(
      farmId: farmId,
      expenseId: expenseId,
      payload: payload,
    );
  }

  Future<void> deleteExpense({
    required String farmId,
    required String expenseId,
  }) {
    return api.deleteExpense(farmId: farmId, expenseId: expenseId);
  }
}
