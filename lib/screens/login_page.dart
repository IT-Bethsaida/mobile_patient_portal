import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/app_theme.dart';
import 'package:patient_portal/components/social_login_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneController = TextEditingController();
  bool _isLoading = false;
  bool _isGoogleLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _handlePhoneLogin() {
    // Validate phone number
    if (_phoneController.text.isEmpty || _phoneController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan nomor telepon yang valid'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate OTP sending process
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        // Navigate to OTP verification page with phone number
        Navigator.pushNamed(
          context,
          '/otp-verification',
          arguments: _phoneController.text,
        );
      }
    });
  }

  void _handleGoogleLogin() {
    setState(() {
      _isGoogleLoading = true;
    });

    // Simulate Google login process
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isGoogleLoading = false;
        });
        // TODO: Implement Google login with google_sign_in package
        // Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // width: EdgeInsets.symmetric(horizontal: 24),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDarkMode
                  ? [AppColors.primaryDark, AppColors.grey900]
                  : [AppColors.primaryLight, Colors.white],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.screenPaddingHorizontal,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo Section
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/logo_only_bg_white.png',
                        width: 150,
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 24),
                      Column(
                        children: [
                          Text(
                            'BETHSAIDA',
                            style: AppTypography.headlineLarge.copyWith(
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.primary,
                              fontFamily: 'GillSansCondensedBold',
                              fontSize: 45,
                            ),
                          ),
                          Text(
                            'Hospital with Heart',
                            style: AppTypography.bodyMedium.copyWith(
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.primary,
                              fontFamily: 'BrushScript',
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              height: 0.1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),

                // Phone Number Field
                Text(
                  'Nomor Telepon',
                  style: AppTypography.titleMedium.copyWith(
                    color: isDarkMode ? AppColors.white : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(
                      color: isDarkMode
                          ? AppColors.white
                          : AppColors.textPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Contoh: 08123456789',
                      hintStyle: TextStyle(
                        color: isDarkMode
                            ? AppColors.grey500
                            : AppColors.grey400,
                      ),
                      prefixIcon: Icon(
                        Icons.phone_outlined,
                        color: isDarkMode
                            ? AppColors.grey400
                            : AppColors.grey600,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: isDarkMode
                          ? AppColors.grey800
                          : AppColors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Info Text
                Text(
                  'Kami akan mengirimkan kode OTP ke nomor telepon Anda',
                  style: AppTypography.bodySmall.copyWith(
                    color: isDarkMode
                        ? AppColors.grey300
                        : AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // Login Button
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handlePhoneLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 20,
                      ),
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.white,
                              ),
                            ),
                          )
                        : Text('Kirim OTP', style: AppTypography.button),
                  ),
                ),
                const SizedBox(height: 24),

                // Divider with text
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: isDarkMode
                            ? AppColors.grey600
                            : AppColors.grey400,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'Atau lanjutkan dengan',
                        style: AppTypography.bodySmall.copyWith(
                          color: isDarkMode
                              ? AppColors.grey300
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: isDarkMode
                            ? AppColors.grey600
                            : AppColors.grey400,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Google Login Button
                SocialLoginButton(
                  label: 'Sign in with Google',
                  imageIcon: const AssetImage('assets/icon_google.png'),
                  backgroundColor: isDarkMode
                      ? AppColors.grey800
                      : Colors.white,
                  borderColor: isDarkMode ? AppColors.grey600 : AppColors.black,
                  isLoading: _isGoogleLoading,
                  isOutline: true,
                  onPressed: _handleGoogleLogin,
                ),
                const SizedBox(height: 16),

                // Sign Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Belum punya akun? ",
                      style: AppTypography.bodySmall.copyWith(
                        color: isDarkMode
                            ? AppColors.grey300
                            : AppColors.textPrimary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: Navigate to sign up page
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        overlayColor: Colors.transparent,
                      ),
                      child: Text(
                        'Daftar',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
