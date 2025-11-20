import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
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
