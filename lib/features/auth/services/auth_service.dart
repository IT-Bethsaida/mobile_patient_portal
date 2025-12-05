import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patient_portal/features/auth/models/register_request.dart';
import 'package:patient_portal/features/auth/models/register_response.dart';
import 'package:patient_portal/features/auth/models/otp_request.dart';
import 'package:patient_portal/features/auth/models/otp_response.dart';
import 'package:patient_portal/features/auth/models/verify_otp_request.dart';
import 'package:patient_portal/features/auth/models/verify_otp_response.dart';
import 'package:patient_portal/features/auth/models/refresh_token_response.dart';
import 'package:patient_portal/features/auth/models/user_model.dart';
import 'package:patient_portal/core/network/api_response.dart';
import 'package:patient_portal/core/network/api_client.dart';
import 'package:patient_portal/core/config/env_config.dart';

class AuthService {
  static String get baseUrl => EnvConfig.apiBaseUrl;

  static Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Future<ApiResponse<RegisterResponse>> register(
    RegisterRequest request,
  ) async {
    try {
      final uri = Uri.parse('$baseUrl/auth/register');

      final response = await http
          .post(uri, headers: _headers, body: jsonEncode(request.toJson()))
          .timeout(Duration(seconds: EnvConfig.apiTimeout));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final registerResponse = RegisterResponse.fromJson(json);

        return ApiResponse.success(
          data: registerResponse,
          message: json['message'] ?? 'Registration successful',
        );
      }

      // Handle error responses
      final errorJson = jsonDecode(response.body);
      return ApiResponse.error(
        message: errorJson['message'] ?? 'Registration failed',
        statusCode: response.statusCode,
      );
    } catch (e) {
      return ApiResponse.error(message: 'Error: ${e.toString()}');
    }
  }

  static Future<ApiResponse<OtpResponse>> requestOtp(OtpRequest request) async {
    try {
      final uri = Uri.parse('$baseUrl/auth/otp/request');

      final response = await http
          .post(uri, headers: _headers, body: jsonEncode(request.toJson()))
          .timeout(Duration(seconds: EnvConfig.apiTimeout));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final otpResponse = OtpResponse.fromJson(json);

        return ApiResponse.success(
          data: otpResponse,
          message: json['message'] ?? 'OTP sent successfully',
        );
      }

      // Handle error responses
      final errorJson = jsonDecode(response.body);
      return ApiResponse.error(
        message: errorJson['message'] ?? 'Failed to send OTP',
        statusCode: response.statusCode,
      );
    } catch (e) {
      return ApiResponse.error(message: 'Error: ${e.toString()}');
    }
  }

  static Future<ApiResponse<VerifyOtpResponse>> verifyOtp(
    VerifyOtpRequest request,
  ) async {
    try {
      final uri = Uri.parse('$baseUrl/auth/otp/verify');

      final response = await http
          .post(uri, headers: _headers, body: jsonEncode(request.toJson()))
          .timeout(Duration(seconds: EnvConfig.apiTimeout));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final verifyOtpResponse = VerifyOtpResponse.fromJson(json);

        return ApiResponse.success(
          data: verifyOtpResponse,
          message: json['message'] ?? 'OTP verified successfully',
        );
      }

      // Handle error responses
      final errorJson = jsonDecode(response.body);
      return ApiResponse.error(
        message: errorJson['message'] ?? 'Failed to verify OTP',
        statusCode: response.statusCode,
      );
    } catch (e) {
      return ApiResponse.error(message: 'Error: ${e.toString()}');
    }
  }

  static Future<ApiResponse<RefreshTokenResponse>> refreshToken(
    String refreshToken,
  ) async {
    try {
      final uri = Uri.parse('$baseUrl/auth/refresh-token');

      final response = await http
          .post(
            uri,
            headers: _headers,
            body: jsonEncode({'refreshToken': refreshToken}),
          )
          .timeout(Duration(seconds: EnvConfig.apiTimeout));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final refreshTokenResponse = RefreshTokenResponse.fromJson(json);

        return ApiResponse.success(
          data: refreshTokenResponse,
          message: json['message'] ?? 'Token refreshed successfully',
        );
      }

      // Handle error responses
      final errorJson = jsonDecode(response.body);
      return ApiResponse.error(
        message: errorJson['message'] ?? 'Failed to refresh token',
        statusCode: response.statusCode,
      );
    } catch (e) {
      return ApiResponse.error(message: 'Error: ${e.toString()}');
    }
  }

  static Future<ApiResponse<UserModel>> getProfile() async {
    try {
      final uri = Uri.parse('$baseUrl/auth/profile');
      final headers = await ApiClient.getHeaders();

      final response = await http
          .get(uri, headers: headers)
          .timeout(Duration(seconds: EnvConfig.apiTimeout));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final data = json['data'] as Map<String, dynamic>;
        final user = UserModel.fromJson(data);

        return ApiResponse.success(
          data: user,
          message: json['message'] ?? 'Profile retrieved successfully',
        );
      }

      if (response.statusCode == 401) {
        return ApiResponse.error(
          message: 'Session expired. Please login again.',
          statusCode: 401,
        );
      }

      // Handle error responses
      final errorJson = jsonDecode(response.body);
      return ApiResponse.error(
        message: errorJson['message'] ?? 'Failed to get profile',
        statusCode: response.statusCode,
      );
    } catch (e) {
      return ApiResponse.error(message: 'Error: ${e.toString()}');
    }
  }
}
