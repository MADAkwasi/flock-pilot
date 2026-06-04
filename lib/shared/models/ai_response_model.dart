class AiChatResponse {
  final String conversationId;
  final String message;

  const AiChatResponse({required this.conversationId, required this.message});

  factory AiChatResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    final response = data['response'] ?? {};

    return AiChatResponse(
      conversationId: response['conversationId'] ?? '',
      message: response['response'] ?? '',
    );
  }
}
