import 'package:http/http.dart' as http;
import 'package:patient_portal/core/network/api_client.dart';
import 'package:patient_portal/features/auth/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// HTTP Client with automatic token refresh on 401
class HttpClientWithRefresh {
  /// Make GET request with auto token refresh
  static Future<http.Response> get(
    Uri uri, {
    Map<String, String>? headers,
  }) async {
    final requestHeaders = headers ?? await ApiClient.getHeaders();

    // First attempt
    var response = await http.get(uri, headers: requestHeaders);

    // If 401, try to refresh token and retry
    if (response.statusCode == 401) {
      final refreshed = await _refreshToken();

      if (refreshed) {
        // Retry with new token
        final newHeaders = await ApiClient.getHeaders();
        response = await http.get(uri, headers: newHeaders);
      }
    }

    return response;
  }

  /// Make POST request with auto token refresh
  static Future<http.Response> post(
    Uri uri, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final requestHeaders = headers ?? await ApiClient.getHeaders();

    // First attempt
    var response = await http.post(uri, headers: requestHeaders, body: body);

    // If 401, try to refresh token and retry
    if (response.statusCode == 401) {
      final refreshed = await _refreshToken();

      if (refreshed) {
        // Retry with new token
        final newHeaders = await ApiClient.getHeaders();
        response = await http.post(uri, headers: newHeaders, body: body);
      }
    }

    return response;
  }

  /// Make PUT request with auto token refresh
  static Future<http.Response> put(
    Uri uri, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final requestHeaders = headers ?? await ApiClient.getHeaders();

    // First attempt
    var response = await http.put(uri, headers: requestHeaders, body: body);

    // If 401, try to refresh token and retry
    if (response.statusCode == 401) {
      final refreshed = await _refreshToken();

      if (refreshed) {
        // Retry with new token
        final newHeaders = await ApiClient.getHeaders();
        response = await http.put(uri, headers: newHeaders, body: body);
      }
    }

    return response;
  }

  /// Make DELETE request with auto token refresh
  static Future<http.Response> delete(
    Uri uri, {
    Map<String, String>? headers,
  }) async {
    final requestHeaders = headers ?? await ApiClient.getHeaders();

    // First attempt
    var response = await http.delete(uri, headers: requestHeaders);

    // If 401, try to refresh token and retry
    if (response.statusCode == 401) {
      final refreshed = await _refreshToken();

      if (refreshed) {
        // Retry with new token
        final newHeaders = await ApiClient.getHeaders();
        response = await http.delete(uri, headers: newHeaders);
      }
    }

    return response;
  }

  /// Refresh access token using refresh token
  static Future<bool> _refreshToken() async {
    try {
      final refreshToken = await ApiClient.getRefreshToken();

      if (refreshToken == null) {
        return false;
      }

      final response = await AuthService.refreshToken(refreshToken);

      if (response.success && response.data != null) {
        // Save new tokens
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', response.data!.accessToken);
        await prefs.setString('refreshToken', response.data!.refreshToken);
        await prefs.setInt(
          'tokenTimestamp',
          DateTime.now().millisecondsSinceEpoch,
        );

        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }
}
