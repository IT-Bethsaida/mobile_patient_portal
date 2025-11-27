import 'dart:ui' show PlatformDispatcher;
import 'package:flutter/material.dart';

class LocalizationProvider extends ChangeNotifier {
  static const List<String> _supportedLanguages = ['id', 'en'];

  late Locale _locale;

  LocalizationProvider() {
    // Detect device language
    final String deviceLanguage =
        PlatformDispatcher.instance.locale.languageCode;
    _locale = _supportedLanguages.contains(deviceLanguage)
        ? Locale(deviceLanguage)
        : const Locale('en'); // Fallback to English
  }

  Locale get locale => _locale;

  bool get isIndonesian => _locale.languageCode == 'id';
  bool get isEnglish => _locale.languageCode == 'en';

  void setLocale(Locale locale) {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
  }

  void toggleLanguage() {
    _locale = _locale.languageCode == 'id'
        ? const Locale('en')
        : const Locale('id');
    notifyListeners();
  }

  void setIndonesian() {
    setLocale(const Locale('id'));
  }

  void setEnglish() {
    setLocale(const Locale('en'));
  }
}
