import 'package:flock_pilot/core/api/farm_api.dart';
import 'package:flock_pilot/core/services/farm/farm_notifier.dart';
import 'package:flock_pilot/data/farm_repository.dart';
import 'package:flock_pilot/provider/auth_provider.dart';
import 'package:flock_pilot/state/farm_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final farmApiProvider = Provider<FarmApi>((ref) {
  return FarmApi(ref.read(dioProvider));
});

final farmRepositoryProvider = Provider<FarmRepository>((ref) {
  return FarmRepository(ref.read(farmApiProvider));
});

final farmProvider = StateNotifierProvider<FarmNotifier, FarmState>((ref) {
  return FarmNotifier(ref.read(farmRepositoryProvider));
});
