import 'package:flock_pilot/core/api/ai_api.dart';
import 'package:flock_pilot/shared/models/ai_response_model.dart';

class AiChatRepository {
  final AiChatApi api;

  AiChatRepository(this.api);

  Future<AiChatResponse> askAssistant({
    required String farmId,
    required String message,
    String? conversationId,
  }) {
    return api.askAssistant(
      farmId: farmId,
      message: message,
      conversationId: conversationId,
    );
  }

  Future<List<ChatMessageModel>> getConversationMessages({
    required String farmId,
    required String conversationId,
  }) {
    return api.getConversationMessages(
      farmId: farmId,
      conversationId: conversationId,
    );
  }
}
