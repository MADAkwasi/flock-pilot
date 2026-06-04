import 'package:dio/dio.dart';
import 'package:flock_pilot/shared/models/ai_response_model.dart';

class AiChatApi {
  final Dio dio;

  AiChatApi(this.dio);

  Future<AiChatResponse> askAssistant({
    required String farmId,
    required String message,
    String? conversationId,
  }) async {
    final res = await dio.post(
      '/ai-assistant/$farmId/ask',
      data: {
        "content": message,
        if (conversationId != null) "conversationId": conversationId,
      },
    );

    return AiChatResponse.fromJson(res.data);
  }

  Future<List<ChatMessageModel>> getConversationMessages({
    required String farmId,
    required String conversationId,
  }) async {
    final res = await dio.get(
      '/ai-assistant/$farmId/conversation/$conversationId',
    );

    final messages =
        res.data['data']?['response']?['messages'] as List<dynamic>? ?? [];

    return messages.map((e) => ChatMessageModel.fromJson(e)).toList();
  }
}
