import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
  ];

  /// Nama lengkap aplikasi
  ///
  /// In id, this message translates to:
  /// **'Bethsaida Hospital'**
  String get appName;

  /// Nama singkat aplikasi
  ///
  /// In id, this message translates to:
  /// **'Bethsaida'**
  String get shortAppName;

  /// Slogan utama aplikasi
  ///
  /// In id, this message translates to:
  /// **'Hospital with Heart'**
  String get tagline;

  /// Teks indikator saat proses berjalan
  ///
  /// In id, this message translates to:
  /// **'Memuat...'**
  String get loading;

  /// Teks untuk menampilkan pesan error umum
  ///
  /// In id, this message translates to:
  /// **'Error'**
  String get error;

  /// Teks untuk menampilkan pesan sukses umum
  ///
  /// In id, this message translates to:
  /// **'Berhasil'**
  String get success;

  /// Teks untuk fitur yang akan segera hadir
  ///
  /// In id, this message translates to:
  /// **'segera hadir'**
  String get comingSoon;

  /// Tombol untuk melihat semua item
  ///
  /// In id, this message translates to:
  /// **'Lihat Semua'**
  String get seeAll;

  /// Teks awalan untuk tanggal berlaku promo
  ///
  /// In id, this message translates to:
  /// **'Berlaku hingga'**
  String get validUntil;

  /// Label untuk input nomor telepon
  ///
  /// In id, this message translates to:
  /// **'Nomor Telepon'**
  String get phoneNumber;

  /// Contoh format nomor telepon
  ///
  /// In id, this message translates to:
  /// **'Contoh: 08123456789'**
  String get phoneNumberHint;

  /// Tombol untuk mengirim kode OTP
  ///
  /// In id, this message translates to:
  /// **'Kirim OTP'**
  String get sendOTP;

  /// Informasi bahwa OTP akan dikirim ke nomor pengguna
  ///
  /// In id, this message translates to:
  /// **'Kami akan mengirimkan kode OTP ke nomor telepon Anda'**
  String get otpInfo;

  /// Teks pemisah metode login alternatif
  ///
  /// In id, this message translates to:
  /// **'Atau lanjutkan dengan'**
  String get orContinueWith;

  /// Tombol login menggunakan akun Google
  ///
  /// In id, this message translates to:
  /// **'Sign in with Google'**
  String get signInWithGoogle;

  /// Teks untuk menanyakan pengguna jika belum memiliki akun
  ///
  /// In id, this message translates to:
  /// **'Belum punya akun?'**
  String get noAccount;

  /// Tombol pendaftaran akun baru
  ///
  /// In id, this message translates to:
  /// **'Daftar'**
  String get register;

  /// Pesan validasi untuk nomor telepon yang tidak sesuai
  ///
  /// In id, this message translates to:
  /// **'Masukkan nomor telepon yang valid'**
  String get enterValidPhoneNumber;

  /// Menu item untuk informasi rumah sakit
  ///
  /// In id, this message translates to:
  /// **'Informasi\nRumah Sakit'**
  String get hospitalsInformation;

  /// Menu item untuk riwayat rawat jalan
  ///
  /// In id, this message translates to:
  /// **'Riwayat\nRawat Jalan'**
  String get outpatientHistory;

  /// Menu item untuk laboratorium
  ///
  /// In id, this message translates to:
  /// **'Laboratorium'**
  String get laboratory;

  /// Menu item untuk radiologi
  ///
  /// In id, this message translates to:
  /// **'Radiologi'**
  String get radiology;

  /// Menu item untuk tes mandiri
  ///
  /// In id, this message translates to:
  /// **'Tes Mandiri'**
  String get selfTest;

  /// Menu item untuk pembayaran mandiri
  ///
  /// In id, this message translates to:
  /// **'Pembayaran Mandiri'**
  String get selfPayment;

  /// Menu item untuk kuis
  ///
  /// In id, this message translates to:
  /// **'Kuis'**
  String get quiz;

  /// Menu item untuk check-in mandiri
  ///
  /// In id, this message translates to:
  /// **'Check-in Mandiri'**
  String get selfCheckin;

  /// Judul bagian untuk daftar dokter
  ///
  /// In id, this message translates to:
  /// **'Dokter Kami'**
  String get ourDoctors;

  /// Judul bagian untuk promosi spesial
  ///
  /// In id, this message translates to:
  /// **'Promo Spesial'**
  String get specialPromo;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
