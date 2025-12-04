import 'package:shared_preferences/shared_preferences.dart';

/// API Client helper untuk mengelola headers dan authentication
class ApiClient {
  /// Get headers dengan authentication token jika tersedia
  static Future<Map<String, String>> getHeaders() async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // Add authorization token if available
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  /// Get headers tanpa authentication (untuk public endpoints)
  static Map<String, String> getPublicHeaders() {
    return {'Content-Type': 'application/json', 'Accept': 'application/json'};
  }

  /// Get access token from SharedPreferences
  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  /// Get refresh token from SharedPreferences
  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refreshToken');
  }
}
