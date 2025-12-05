import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure storage for sensitive data (tokens, credentials)
/// Uses Android Keystore and iOS Keychain for hardware-backed encryption
class SecureStorage {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  // Token keys
  static const String _accessTokenKey = 'accessToken';
  static const String _refreshTokenKey = 'refreshToken';
  static const String _tokenTimestampKey = 'tokenTimestamp';

  // User data keys
  static const String _userIdKey = 'userId';
  static const String _userNameKey = 'userName';
  static const String _userEmailKey = 'userEmail';
  static const String _userPhoneKey = 'userPhone';
  static const String _userDobKey = 'userDob';
  static const String _userRoleKey = 'userRole';

  /// Save access token
  static Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _accessTokenKey, value: token);
  }

  /// Get access token
  static Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  /// Save refresh token
  static Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _refreshTokenKey, value: token);
  }

  /// Get refresh token
  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  /// Save token timestamp
  static Future<void> saveTokenTimestamp(int timestamp) async {
    await _storage.write(key: _tokenTimestampKey, value: timestamp.toString());
  }

  /// Get token timestamp
  static Future<int?> getTokenTimestamp() async {
    final value = await _storage.read(key: _tokenTimestampKey);
    return value != null ? int.tryParse(value) : null;
  }

  /// Save user data
  static Future<void> saveUserData({
    required String userId,
    required String userName,
    required String userEmail,
    required String userPhone,
    String? userDob,
    required String userRole,
  }) async {
    await Future.wait([
      _storage.write(key: _userIdKey, value: userId),
      _storage.write(key: _userNameKey, value: userName),
      _storage.write(key: _userEmailKey, value: userEmail),
      _storage.write(key: _userPhoneKey, value: userPhone),
      if (userDob != null) _storage.write(key: _userDobKey, value: userDob),
      _storage.write(key: _userRoleKey, value: userRole),
    ]);
  }

  /// Get user ID
  static Future<String?> getUserId() async {
    return await _storage.read(key: _userIdKey);
  }

  /// Get user name
  static Future<String?> getUserName() async {
    return await _storage.read(key: _userNameKey);
  }

  /// Get user email
  static Future<String?> getUserEmail() async {
    return await _storage.read(key: _userEmailKey);
  }

  /// Get user phone
  static Future<String?> getUserPhone() async {
    return await _storage.read(key: _userPhoneKey);
  }

  /// Get user date of birth
  static Future<String?> getUserDob() async {
    return await _storage.read(key: _userDobKey);
  }

  /// Get user role
  static Future<String?> getUserRole() async {
    return await _storage.read(key: _userRoleKey);
  }

  /// Clear all secure data (logout)
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  /// Delete specific key
  static Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }
}
