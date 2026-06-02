import 'package:flock_pilot/core/api/farm_api.dart';
import 'package:flock_pilot/shared/models/farm_model.dart';

class FarmRepository {
  final FarmApi api;

  FarmRepository(this.api);

  Future<FarmModel> getFarm(String farmId) async {
    return api.getFarm(farmId);
  }
}
