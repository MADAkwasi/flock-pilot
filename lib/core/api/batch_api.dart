import 'package:dio/dio.dart';

class BatchApi {
  final Dio dio;

  BatchApi(this.dio);

  Future<Map<String, dynamic>> getBatch({
    required String farmId,
    required String batchId,
  }) async {
    final res = await dio.get('/flocks/$farmId/flock/$batchId');
    return res.data['data']['flock'];
  }
}
