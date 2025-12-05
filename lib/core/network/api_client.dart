import 'package:patient_portal/core/storage/secure_storage.dart';

/// API Client helper untuk mengelola headers dan authentication
class ApiClient {
  /// Get headers dengan authentication token jika tersedia
  static Future<Map<String, String>> getHeaders() async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // Add authorization token if available
    final token = await SecureStorage.getAccessToken();
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  /// Get headers tanpa authentication (untuk public endpoints)
  static Map<String, String> getPublicHeaders() {
    return {'Content-Type': 'application/json', 'Accept': 'application/json'};
  }

  /// Get access token from Secure Storage
  static Future<String?> getAccessToken() async {
    return await SecureStorage.getAccessToken();
  }

  /// Get refresh token from Secure Storage
  static Future<String?> getRefreshToken() async {
    return await SecureStorage.getRefreshToken();
  }
}
