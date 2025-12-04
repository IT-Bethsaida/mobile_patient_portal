import 'package:patient_portal/features/auth/models/user_model.dart';

class VerifyOtpResponse {
  final String message;
  final UserModel user;
  final String accessToken;
  final String refreshToken;

  VerifyOtpResponse({
    required this.message,
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    // Handle nested data structure from API
    final data = json['data'] as Map<String, dynamic>? ?? json;

    return VerifyOtpResponse(
      message: json['message'] as String,
      user: UserModel.fromJson(data['user'] as Map<String, dynamic>),
      accessToken: data['accessToken'] as String,
      refreshToken: data['refreshToken'] as String,
    );
  }
}
