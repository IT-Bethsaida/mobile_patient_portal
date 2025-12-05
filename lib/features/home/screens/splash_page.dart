import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/features/auth/providers/auth_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    if (!mounted) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      // Load saved authentication and ensure minimum splash duration
      await Future.wait([
        authProvider.loadSavedAuth(),
        Future.delayed(
          const Duration(milliseconds: 1500),
        ), // Minimum display time
      ]);

      if (!mounted) return;

      // If user has saved auth, try to refresh token to ensure it's valid
      if (authProvider.isAuthenticated) {
        // Try to refresh token silently
        final refreshSuccess = await authProvider.refreshAccessToken();

        if (!mounted) return;

        if (refreshSuccess) {
          // Token refreshed successfully, go to home
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          // Refresh failed, token might be expired, go to login
          await authProvider.logout();
          if (!mounted) return;
          Navigator.pushReplacementNamed(context, '/login');
        }
      } else {
        // No saved auth, go to login
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      // If error occurs, navigate to login
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: Container(
        color: AppColors.primary,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Hospital Logo
              Image.asset(
                'assets/images/logo_only.png',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 24),

              // Hospital Name
              Column(
                children: [
                  Text(
                    'BETHSAIDA',
                    style: AppTypography.headlineLarge.copyWith(
                      color: AppColors.white,
                      fontFamily: 'GillSansCondensedBold',
                      fontSize: 45,
                    ),
                  ),
                  Text(
                    'Hospital with Heart',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.white,
                      fontFamily: 'BrushScript',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      height: 0.1,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 48),

              // Loading Indicator
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
