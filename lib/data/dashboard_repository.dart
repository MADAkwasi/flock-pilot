import 'package:flock_pilot/core/api/dashboard_api.dart';
import 'package:flock_pilot/shared/models/dashboard_model.dart';

class DashboardRepository {
  final DashboardApi api;

  DashboardRepository(this.api);

  Future<DashboardModel> getDashboard(String farmId) {
    return api.getDashboard(farmId);
  }
}
