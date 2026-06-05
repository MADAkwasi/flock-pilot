import 'package:flock_pilot/core/api/batch_api.dart';
import 'package:flock_pilot/data/batch_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flock_pilot/core/api/api_client.dart';
import 'package:flock_pilot/shared/models/flock_model.dart';

// API PROVIDER
final flockApiProvider = Provider<BatchApi>((ref) {
  return BatchApi(ApiClient.dio);
});

// REPOSITORY PROVIDER
final flockRepositoryProvider = Provider<BatchRepository>((ref) {
  final api = ref.read(flockApiProvider);
  return BatchRepository(api);
});

// FLOCK/BATCH PROVIDER
final batchProvider =
    FutureProvider.family<FlockModel, ({String farmId, String batchId})>((
      ref,
      params,
    ) async {
      final repo = ref.read(flockRepositoryProvider);

      return repo.getBatch(farmId: params.farmId, batchId: params.batchId);
    });
