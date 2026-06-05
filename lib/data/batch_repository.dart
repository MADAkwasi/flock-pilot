import 'package:flock_pilot/core/api/batch_api.dart';
import 'package:flock_pilot/shared/models/flock_model.dart';

class BatchRepository {
  final BatchApi api;

  BatchRepository(this.api);

  Future<FlockModel> getBatch({
    required String farmId,
    required String batchId,
  }) async {
    final data = await api.getBatch(farmId: farmId, batchId: batchId);
    return FlockModel.fromJson(data);
  }
}
