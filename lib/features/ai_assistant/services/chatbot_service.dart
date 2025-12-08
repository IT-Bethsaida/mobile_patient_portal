import 'dart:convert';
import 'package:patient_portal/core/network/api_response.dart';
import 'package:patient_portal/core/network/http_client_with_refresh.dart';
import 'package:patient_portal/core/config/env_config.dart';
import 'package:patient_portal/features/ai_assistant/models/chatbot_response.dart';

class ChatbotService {
  static String get baseUrl => EnvConfig.apiBaseUrl;

  /// Send message to chatbot
  static Future<ApiResponse<ChatbotResponse>> sendMessage(
    String message,
  ) async {
    try {
      final uri = Uri.parse('$baseUrl/chatbot/message');

      final response = await HttpClientWithRefresh.post(
        uri,
        body: jsonEncode({'message': message}),
      ).timeout(Duration(seconds: EnvConfig.apiTimeout));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final chatbotResponse = ChatbotResponse.fromJson(
          json['data'] as Map<String, dynamic>,
        );

        return ApiResponse.success(
          data: chatbotResponse,
          message: json['message'] ?? 'Success',
        );
      }

      if (response.statusCode == 401) {
        return ApiResponse.error(
          message: 'Session expired. Please login again.',
          statusCode: 401,
        );
      }

      return ApiResponse.error(
        message: 'Failed to send message',
        statusCode: response.statusCode,
      );
    } catch (e) {
      return ApiResponse.error(message: 'Error: ${e.toString()}');
    }
  }

  /// Get chat history
  static Future<ApiResponse<ChatHistoryResponse>> getHistory({
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/chatbot/history').replace(
        queryParameters: {
          'limit': limit.toString(),
          'offset': offset.toString(),
        },
      );

      final response = await HttpClientWithRefresh.get(
        uri,
      ).timeout(Duration(seconds: EnvConfig.apiTimeout));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final historyResponse = ChatHistoryResponse.fromJson(
          json['data'] as Map<String, dynamic>,
        );

        return ApiResponse.success(
          data: historyResponse,
          message: json['message'] ?? 'Success',
        );
      }

      if (response.statusCode == 401) {
        return ApiResponse.error(
          message: 'Session expired. Please login again.',
          statusCode: 401,
        );
      }

      return ApiResponse.error(
        message: 'Failed to load history: ${response.body}',
        statusCode: response.statusCode,
      );
    } catch (e) {
      return ApiResponse.error(message: 'Error: ${e.toString()}');
    }
  }

  /// Clear chat history
  static Future<ApiResponse<void>> clearHistory() async {
    try {
      final uri = Uri.parse('$baseUrl/chatbot/history');

      final response = await HttpClientWithRefresh.delete(
        uri,
      ).timeout(Duration(seconds: EnvConfig.apiTimeout));

      if (response.statusCode == 200 || response.statusCode == 204) {
        return ApiResponse.success(
          data: null,
          message: 'History cleared successfully',
        );
      }

      if (response.statusCode == 401) {
        return ApiResponse.error(
          message: 'Session expired. Please login again.',
          statusCode: 401,
        );
      }

      return ApiResponse.error(
        message: 'Failed to clear history',
        statusCode: response.statusCode,
      );
    } catch (e) {
      return ApiResponse.error(message: 'Error: ${e.toString()}');
    }
  }
}
