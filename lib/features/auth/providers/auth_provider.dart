import 'package:flutter/material.dart';
import 'package:patient_portal/core/storage/secure_storage.dart';
import 'package:patient_portal/features/auth/models/user_model.dart';
import 'package:patient_portal/features/auth/models/register_request.dart';
import 'package:patient_portal/features/auth/models/otp_request.dart';
import 'package:patient_portal/features/auth/models/verify_otp_request.dart';
import 'package:patient_portal/features/auth/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _user;
  String? _accessToken;
  String? _refreshToken;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _accessToken != null;

  Future<bool> register({
    required String name,
    required String email,
    required String phoneNumber,
    required DateTime dob,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final request = RegisterRequest(
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        dob: _formatDate(dob),
        password: password,
      );

      final response = await AuthService.register(request);

      if (response.success && response.data != null) {
        _user = response.data!.user;
        _accessToken = response.data!.accessToken;
        _refreshToken = response.data!.refreshToken;

        await _saveTokens();

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = response.message;
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _saveTokens() async {
    // Save tokens to secure storage
    await SecureStorage.saveAccessToken(_accessToken!);
    await SecureStorage.saveRefreshToken(_refreshToken!);
    await SecureStorage.saveTokenTimestamp(
      DateTime.now().millisecondsSinceEpoch,
    );

    // Save user data to secure storage
    await SecureStorage.saveUserData(
      userId: _user!.id,
      userName: _user!.name,
      userEmail: _user!.email,
      userPhone: _user!.phoneNumber,
      userDob: _user!.dob,
      userRole: _user!.role,
    );
  }

  Future<void> loadSavedAuth() async {
    // Load tokens from secure storage
    _accessToken = await SecureStorage.getAccessToken();
    _refreshToken = await SecureStorage.getRefreshToken();

    if (_accessToken != null) {
      // Load user data from secure storage
      final userId = await SecureStorage.getUserId();
      final userName = await SecureStorage.getUserName();
      final userEmail = await SecureStorage.getUserEmail();
      final userPhone = await SecureStorage.getUserPhone();
      final userDob = await SecureStorage.getUserDob();
      final userRole = await SecureStorage.getUserRole();

      if (userId != null && userName != null && userEmail != null) {
        // Create a minimal user object from saved data
        _user = UserModel(
          id: userId,
          name: userName,
          email: userEmail,
          phoneNumber: userPhone ?? '',
          dob: userDob,
          role: userRole ?? 'patient',
          createdAt: DateTime.now(),
        );
        notifyListeners();
      }
    }
  }

  Future<bool> requestOtp(String phoneNumber) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final request = OtpRequest(phoneNumber: phoneNumber);
      final response = await AuthService.requestOtp(request);

      if (response.success) {
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = response.message;
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> verifyOtp({
    required String phoneNumber,
    required String code,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final request = VerifyOtpRequest(phoneNumber: phoneNumber, code: code);

      final response = await AuthService.verifyOtp(request);

      if (response.success && response.data != null) {
        _user = response.data!.user;
        _accessToken = response.data!.accessToken;
        _refreshToken = response.data!.refreshToken;

        await _saveTokens();

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = response.message;
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> refreshAccessToken() async {
    if (_refreshToken == null) {
      return false;
    }

    try {
      final response = await AuthService.refreshToken(_refreshToken!);

      if (response.success && response.data != null) {
        _accessToken = response.data!.accessToken;
        _refreshToken = response.data!.refreshToken;

        // Save new tokens to secure storage
        await SecureStorage.saveAccessToken(_accessToken!);
        await SecureStorage.saveRefreshToken(_refreshToken!);
        await SecureStorage.saveTokenTimestamp(
          DateTime.now().millisecondsSinceEpoch,
        );

        notifyListeners();
        return true;
      } else {
        // Refresh token failed, logout user
        await logout();
        return false;
      }
    } catch (e) {
      // Refresh token failed, logout user
      await logout();
      return false;
    }
  }

  Future<bool> fetchProfile() async {
    if (_accessToken == null) {
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await AuthService.getProfile();

      if (response.success && response.data != null) {
        _user = response.data;

        // Update saved user data to secure storage
        await SecureStorage.saveUserData(
          userId: _user!.id,
          userName: _user!.name,
          userEmail: _user!.email,
          userPhone: _user!.phoneNumber,
          userDob: _user!.dob,
          userRole: _user!.role,
        );

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = response.message;
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    // Clear all secure storage
    await SecureStorage.clearAll();

    _user = null;
    _accessToken = null;
    _refreshToken = null;
    _errorMessage = null;

    notifyListeners();
  }
}
