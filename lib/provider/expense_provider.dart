import 'package:flock_pilot/core/api/expense_api.dart';
import 'package:flock_pilot/data/expense_repository.dart';
import 'package:flock_pilot/provider/auth_provider.dart';
import 'package:flock_pilot/provider/farm_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final expenseApiProvider = Provider<ExpenseApi>((ref) {
  final dio = ref.read(dioProvider);
  return ExpenseApi(dio);
});

final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) {
  return ExpenseRepository(ref.read(expenseApiProvider));
});

final expenseControllerProvider =
    StateNotifierProvider<ExpenseController, AsyncValue<void>>((ref) {
      return ExpenseController(ref.read(expenseRepositoryProvider), ref);
    });

class ExpenseController extends StateNotifier<AsyncValue<void>> {
  final ExpenseRepository _repo;
  final Ref ref;

  ExpenseController(this._repo, this.ref) : super(const AsyncValue.data(null));

  Future<void> createExpense(Map<String, dynamic> payload) async {
    state = const AsyncValue.loading();

    try {
      final farm = ref.read(farmProvider).farm;

      if (farm == null) {
        throw Exception("No farm selected");
      }

      await _repo.createExpense(farmId: farm.id, payload: payload);

      await ref.read(farmProvider.notifier).loadFarm(farm.id);

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);

      rethrow; // 🔥 THIS IS THE MISSING PIECE
    }
  }
}
