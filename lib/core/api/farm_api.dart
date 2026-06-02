import 'package:dio/dio.dart';
import 'package:flock_pilot/shared/models/farm_model.dart';

class FarmApi {
  final Dio dio;

  FarmApi(this.dio);

  Future<FarmModel> getFarm(String farmId) async {
    final res = await dio.get('/farms/$farmId');

    final data = res.data['data'];

    final farmJson = data['farm'] ?? data;

    final farm = FarmModel.fromJson(farmJson);

    return farm;
  }
}
