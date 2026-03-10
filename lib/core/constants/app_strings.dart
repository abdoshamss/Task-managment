/// App string keys and static labels.
/// For localized strings use [AppLocalizations] from generated l10n.
/// This file can hold non-localized constants (e.g. Firestore field names).
class AppStrings {
  AppStrings._();

  // App identity
  static const String appName = 'TaskFlow';
  static const String packageName = 'com.example.taskflow';

  // SharedPreferences keys (used by SettingsProvider)
  static const String keyIsDarkMode = 'isDarkMode';
  static const String keyLanguageCode = 'languageCode';

  // Firestore paths
  static const String usersCollection = 'users';
  static const String tasksSubcollection = 'tasks';
}
