// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Bethsaida Hospital';

  @override
  String get shortAppName => 'Bethsaida';

  @override
  String get tagline => 'Hospital with Heart';

  @override
  String get loading => 'Loading...';

  @override
  String get error => 'Error';

  @override
  String get success => 'Success';

  @override
  String get comingSoon => 'coming soon';

  @override
  String get seeAll => 'See All';

  @override
  String get validUntil => 'Valid until';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get phoneNumberHint => 'Example: 08123456789';

  @override
  String get sendOTP => 'Send OTP';

  @override
  String get otpInfo => 'We will send an OTP code to your phone number';

  @override
  String get orContinueWith => 'Or continue with';

  @override
  String get signInWithGoogle => 'Sign in with Google';

  @override
  String get noAccount => 'Don\'t have an account?';

  @override
  String get register => 'Sign Up';

  @override
  String get enterValidPhoneNumber => 'Enter a valid phone number';

  @override
  String get hospitalsInformation => 'Hospitals';

  @override
  String get outpatientHistory => 'Outpatient\nHistory';

  @override
  String get laboratory => 'Laboratory';

  @override
  String get quiz => 'Quiz';

  @override
  String get doctors => 'Specialists';

  @override
  String get premiumServices => 'Premium Services';

  @override
  String get radiology => 'Radiology';

  @override
  String get selfTest => 'Self Test';

  @override
  String get selfPayment => 'Self Payment';

  @override
  String get selfCheckin => 'Self Checkin';

  @override
  String get ourDoctors => 'Our Doctors';

  @override
  String get specialPromo => 'Special Promo';

  @override
  String get searchDoctor => 'Search Doctor';

  @override
  String get emergency => 'Emergency';

  @override
  String homeWelcomeTitle(String appName) {
    return 'Welcome to $appName';
  }

  @override
  String get homeWelcomeSubtitle => 'How can we help you today?';
}
