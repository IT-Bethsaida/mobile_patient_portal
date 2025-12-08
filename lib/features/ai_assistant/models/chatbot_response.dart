class ChatbotResponse {
  final String id;
  final String? userId;
  final String role;
  final String content;
  final DateTime createdAt;

  ChatbotResponse({
    required this.id,
    this.userId,
    required this.role,
    required this.content,
    required this.createdAt,
  });

  factory ChatbotResponse.fromJson(Map<String, dynamic> json) {
    return ChatbotResponse(
      id: json['id'] as String,
      userId: json['userId'] as String?,
      role: json['role'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}

class ChatHistoryResponse {
  final List<ChatbotResponse> messages;
  final int total;

  ChatHistoryResponse({required this.messages, required this.total});

  factory ChatHistoryResponse.fromJson(Map<String, dynamic> json) {
    final messagesList = json['messages'] as List<dynamic>;
    final messages = messagesList
        .map((item) => ChatbotResponse.fromJson(item as Map<String, dynamic>))
        .toList();

    return ChatHistoryResponse(messages: messages, total: json['total'] as int);
  }
}
