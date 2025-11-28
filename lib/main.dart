import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:patient_portal/core/app_theme.dart';
import 'package:patient_portal/core/theme_provider.dart';
import 'package:patient_portal/core/localization_provider.dart';
import 'package:patient_portal/gen_l10n/app_localizations.dart';
import 'package:patient_portal/screens/splash_page.dart';
import 'package:patient_portal/screens/login_page.dart';
import 'package:patient_portal/screens/register_page.dart';
import 'package:patient_portal/screens/otp_verification_page.dart';
import 'package:patient_portal/screens/outpatient_history_page.dart';
import 'package:patient_portal/screens/hospital_information_page.dart';
import 'package:patient_portal/screens/settings_page.dart';
import 'package:patient_portal/screens/select_doctor_page.dart';
import 'package:patient_portal/screens/all_services_page.dart';
import 'package:patient_portal/screens/search_doctor_page.dart';
import 'package:patient_portal/screens/specialists_page.dart';
import 'package:patient_portal/screens/emergency_page.dart';
import 'package:patient_portal/screens/premium_services_page.dart';
import 'package:patient_portal/screens/all_doctors_page.dart';
import 'package:patient_portal/screens/all_promos_page.dart';
import 'package:patient_portal/screens/radiology_results_page.dart';
import 'package:patient_portal/screens/lab_results_page.dart';
import 'package:patient_portal/screens/medications_page.dart';
import 'package:patient_portal/screens/notifications_page.dart';
import 'package:patient_portal/widgets/main_wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => LocalizationProvider()),
      ],
      child: Consumer2<ThemeProvider, LocalizationProvider>(
        builder: (context, themeProvider, localizationProvider, child) {
          return MaterialApp(
            title: 'Bethsaida Hospital',
            debugShowCheckedModeBanner: true,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeProvider.isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,
            locale: localizationProvider.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('id'), // Indonesian
              Locale('en'), // English
            ],
            routes: {
              '/': (context) => const SplashPage(),
              '/login': (context) => const LoginPage(),
              '/register': (context) => const RegisterPage(),
              '/otp-verification': (context) => const OtpVerificationPage(),
              '/home': (context) => const MainWrapper(),
              '/hospital-information': (context) =>
                  const HospitalInformationPage(),
              '/outpatient-history': (context) => const OutpatientHistoryPage(),
              '/select-doctor': (context) => const SelectDoctorPage(
                hospital: 'Bethsaida Hospital Gading Serpong',
                specialty: 'General Practitioner',
              ),
              '/settings': (context) => const SettingsPage(),
              '/all-services': (context) => const AllServicesPage(),
              '/search-doctor': (context) => const SearchDoctorPage(),
              '/specialists': (context) => const SpecialistsPage(),
              '/emergency': (context) => const EmergencyPage(),
              '/premium-services': (context) => const PremiumServicesPage(),
              '/all-doctors': (context) => AllDoctorsPage(),
              '/all-promos': (context) => const AllPromosPage(),
              '/radiology-results': (context) => const RadiologyResultsPage(),
              '/lab-results': (context) => const LabResultsPage(),
              '/medications': (context) => const MedicationsPage(),
              '/notifications': (context) => const NotificationsPage(),
            },
          );
        },
      ),
    );
  }
}
