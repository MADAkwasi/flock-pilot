import 'package:flock_pilot/data/expense_repository.dart';
import 'package:flock_pilot/state/expense.dart';
import 'package:flutter_riverpod/legacy.dart';

class ExpenseController extends StateNotifier<ExpenseState> {
  ExpenseController(this._repo) : super(ExpenseState());

  final ExpenseRepository _repo;

  Future<void> createExpense({
    required String farmId,
    required Map<String, dynamic> payload,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _repo.createExpense(farmId: farmId, payload: payload);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      rethrow;
    }
  }
}
