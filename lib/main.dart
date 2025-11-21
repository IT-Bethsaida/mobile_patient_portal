import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:patient_portal/core/app_theme.dart';
import 'package:patient_portal/core/theme_provider.dart';
import 'package:patient_portal/screens/splash_page.dart';
import 'package:patient_portal/screens/login_page.dart';
import 'package:patient_portal/screens/otp_verification_page.dart';
import 'package:patient_portal/widgets/main_wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Bethsaida Hospital',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeProvider.isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,
            routes: {
              '/': (context) => const SplashPage(),
              '/login': (context) => const LoginPage(),
              '/otp-verification': (context) => const OtpVerificationPage(),
              '/home': (context) => const MainWrapper(),
              '/hospital-information': (context) =>
                  const MainWrapper(initialIndex: 1),
            },
          );
        },
      ),
    );
  }
}
