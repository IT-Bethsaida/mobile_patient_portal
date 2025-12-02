import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment configuration
class EnvConfig {
  /// API Base URL
  static String get apiBaseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'https://api.bethsaidahospitals.com/v1';

  /// App Environment (development, staging, production)
  static String get appEnv => dotenv.env['APP_ENV'] ?? 'development';

  /// API Timeout in seconds
  static int get apiTimeout =>
      int.tryParse(dotenv.env['API_TIMEOUT'] ?? '30') ?? 30;

  /// API Key (optional)
  static String? get apiKey => dotenv.env['API_KEY'];

  /// Check if development environment
  static bool get isDevelopment => appEnv == 'development';

  /// Check if staging environment
  static bool get isStaging => appEnv == 'staging';

  /// Check if production environment
  static bool get isProduction => appEnv == 'production';

  /// Print all config (for debugging)
  static void printConfig() {
    print('=== Environment Config ===');
    print('API Base URL: $apiBaseUrl');
    print('App Environment: $appEnv');
    print('API Timeout: ${apiTimeout}s');
    print('API Key: ${apiKey != null ? "***" : "Not set"}');
    print('========================');
  }
}
