import 'package:flock_pilot/data/farm_repository.dart';
import 'package:flock_pilot/state/farm_state.dart';
import 'package:flutter_riverpod/legacy.dart';

class FarmNotifier extends StateNotifier<FarmState> {
  final FarmRepository _repo;

  FarmNotifier(this._repo) : super(FarmState());

  Future<void> loadFarm(String farmId) async {
    state = state.copyWith(isLoading: true);

    try {
      final farm = await _repo.getFarm(farmId);

      state = state.copyWith(isLoading: false, farm: farm);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void clearFarm() {
    state = FarmState(farm: null, isLoading: false, error: null);
  }
}
