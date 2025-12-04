import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/app_theme.dart';
import 'package:patient_portal/gen_l10n/app_localizations.dart';
import 'package:patient_portal/features/auth/widgets/social_login_button.dart';
import 'package:patient_portal/features/auth/providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneController = TextEditingController();
  bool _isGoogleLoading = false;

  @override
  void initState() {
    super.initState();
    // Check if user is already authenticated
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.isAuthenticated) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _handlePhoneLogin() async {
    final l10n = AppLocalizations.of(context)!;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Validate phone number
    if (_phoneController.text.isEmpty || _phoneController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.enterValidPhoneNumber),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Request OTP
    final success = await authProvider.requestOtp(_phoneController.text);

    if (mounted) {
      if (success) {
        // Navigate to OTP verification page with phone number
        Navigator.pushNamed(
          context,
          '/otp-verification',
          arguments: _phoneController.text,
        );
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.errorMessage ?? 'Failed to send OTP'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
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
    final l10n = AppLocalizations.of(context)!;
    final authProvider = Provider.of<AuthProvider>(context);

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
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 600,
                right: -50,
                child: Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(140),
                  ),
                ),
              ),
              Positioned(
                top: 20,
                right: 350,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(110),
                  ),
                ),
              ),
              Positioned(
                top: -100,
                right: 280,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    color: AppColors.primaryDark.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(200),
                  ),
                ),
              ),
              Positioned(
                bottom: -40,
                right: -60,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(90),
                  ),
                ),
              ),
              Positioned(
                top: 550,
                right: -40,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              Positioned(
                top: 120,
                right: 330,
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(80),
                  ),
                ),
              ),
              Padding(
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
                            'assets/images/logo_only.png',
                            width: 150,
                            height: 150,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 24),
                          Column(
                            children: [
                              Text(
                                l10n.shortAppName.toUpperCase(),
                                style: AppTypography.headlineLarge.copyWith(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.primary,
                                  fontFamily: 'GillSansCondensedBold',
                                  fontSize: 45,
                                ),
                              ),
                              Text(
                                l10n.tagline,
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
                      l10n.phoneNumber,
                      style: AppTypography.titleMedium.copyWith(
                        color: isDarkMode
                            ? AppColors.white
                            : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                        color: isDarkMode
                            ? AppColors.white
                            : AppColors.textPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: l10n.phoneNumberHint,
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
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide(
                            color: isDarkMode
                                ? AppColors.grey600
                                : AppColors.grey300,
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide(
                            color: isDarkMode
                                ? AppColors.grey600
                                : AppColors.grey300,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: isDarkMode
                            ? AppColors.grey800
                            : AppColors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Info Text
                    Text(
                      l10n.otpInfo,
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
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: authProvider.isLoading
                            ? null
                            : _handlePhoneLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 24,
                          ),
                          minimumSize: const Size(double.infinity, 56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: authProvider.isLoading
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
                            : Text(l10n.sendOTP, style: AppTypography.button),
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
                            l10n.orContinueWith,
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
                      label: l10n.signInWithGoogle,
                      imageIcon: const AssetImage('assets/icon_google.png'),
                      backgroundColor: isDarkMode
                          ? AppColors.grey800
                          : Colors.white,
                      borderColor: isDarkMode
                          ? AppColors.grey600
                          : AppColors.black,
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
                          "${l10n.noAccount} ",
                          style: AppTypography.bodySmall.copyWith(
                            color: isDarkMode
                                ? AppColors.grey300
                                : AppColors.textPrimary,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            overlayColor: Colors.transparent,
                          ),
                          child: Text(
                            l10n.register,
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
            ],
          ),
        ),
      ),
    );
  }
}
