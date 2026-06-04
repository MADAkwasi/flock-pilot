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

class ChatMessageModel {
  final String id;
  final String role;
  final String message;
  final DateTime createdAt;
  final String conversationId;

  const ChatMessageModel({
    required this.id,
    required this.role,
    required this.message,
    required this.createdAt,
    required this.conversationId,
  });

  bool get isUser => role == 'USER';

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] ?? '',
      role: json['role'] ?? '',
      message: json['message'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      conversationId: json['conversationId'] ?? '',
    );
  }
}
