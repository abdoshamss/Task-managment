import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_strings.dart';

/// Persists and exposes theme and locale. Load on app start.
class SettingsProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  Locale _currentLocale = const Locale('en');

  bool get isDarkMode => _isDarkMode;
  Locale get currentLocale => _currentLocale;

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(AppStrings.keyIsDarkMode) ?? false;
    final code = prefs.getString(AppStrings.keyLanguageCode) ?? 'en';
    _currentLocale = Locale(code);
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppStrings.keyIsDarkMode, _isDarkMode);
    notifyListeners();
  }

  Future<void> changeLanguage(String languageCode) async {
    _currentLocale = Locale(languageCode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppStrings.keyLanguageCode, languageCode);
    notifyListeners();
  }
}
