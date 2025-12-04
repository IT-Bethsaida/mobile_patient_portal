import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', _accessToken!);
    await prefs.setString('refreshToken', _refreshToken!);
    await prefs.setString('userId', _user!.id);
    await prefs.setString('userName', _user!.name);
    await prefs.setString('userEmail', _user!.email);
    await prefs.setString('userPhone', _user!.phoneNumber);
    if (_user!.dob != null) {
      await prefs.setString('userDob', _user!.dob!);
    }
    await prefs.setString('userRole', _user!.role);
  }

  Future<void> loadSavedAuth() async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('accessToken');
    _refreshToken = prefs.getString('refreshToken');

    if (_accessToken != null) {
      // Load user data from preferences
      final userId = prefs.getString('userId');
      final userName = prefs.getString('userName');
      final userEmail = prefs.getString('userEmail');
      final userPhone = prefs.getString('userPhone');
      final userDob = prefs.getString('userDob');
      final userRole = prefs.getString('userRole');

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

        // Save new tokens
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', _accessToken!);
        await prefs.setString('refreshToken', _refreshToken!);

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

        // Update saved user data
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', _user!.id);
        await prefs.setString('userName', _user!.name);
        await prefs.setString('userEmail', _user!.email);

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
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    _user = null;
    _accessToken = null;
    _refreshToken = null;
    _errorMessage = null;

    notifyListeners();
  }
}
