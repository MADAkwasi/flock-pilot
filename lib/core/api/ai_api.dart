import 'package:dio/dio.dart';
import 'package:flock_pilot/shared/models/ai_response_model.dart';

class AiChatApi {
  final Dio dio;

  AiChatApi(this.dio);

  Future<AiChatResponse> askAssistant({
    required String farmId,
    required String message,
  }) async {
    final res = await dio.post(
      '/ai-assistant/$farmId/ask',
      data: {"content": message},
    );

    final data = res.data;

    return AiChatResponse.fromJson(data);
  }
}
