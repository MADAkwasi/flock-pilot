import 'package:flock_pilot/core/api/dashboard_api.dart';
import 'package:flock_pilot/data/dashboard_repository.dart';
import 'package:flock_pilot/provider/auth_provider.dart';
import 'package:flock_pilot/shared/models/dashboard_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardApiProvider = Provider<DashboardApi>((ref) {
  return DashboardApi(ref.read(dioProvider));
});

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepository(ref.read(dashboardApiProvider));
});

final dashboardProvider = FutureProvider.family<DashboardModel, String>((
  ref,
  farmId,
) async {
  return ref.read(dashboardRepositoryProvider).getDashboard(farmId);
});
