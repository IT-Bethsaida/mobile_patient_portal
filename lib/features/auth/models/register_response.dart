import 'package:patient_portal/features/auth/models/user_model.dart';

class RegisterResponse {
  final bool success;
  final String message;
  final UserModel user;
  final String accessToken;
  final String refreshToken;

  RegisterResponse({
    required this.success,
    required this.message,
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      user: UserModel.fromJson(json['data']['user'] as Map<String, dynamic>),
      accessToken: json['data']['accessToken'] as String,
      refreshToken: json['data']['refreshToken'] as String,
    );
  }
}
