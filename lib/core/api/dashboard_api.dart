import 'package:dio/dio.dart';
import 'package:flock_pilot/shared/models/dashboard_model.dart';

class DashboardApi {
  final Dio dio;

  DashboardApi(this.dio);

  Future<DashboardModel> getDashboard(String farmId) async {
    final res = await dio.get('/analytics/$farmId/dashboard-summary');

    return DashboardModel.fromJson(res.data);
  }
}
