import 'package:flutter/material.dart';

import '../Router/navigation_helper.dart';
import '../data_source/hive_service.dart';
import '../utils/general_constants.dart';
import 'generated/app_localizations.dart';

/// flutter gen-l10n
///To Generate Localization Files Run this command: flutter gen-l10n

class LocalizationHelper {
  LocalizationHelper._();
  static final LocalizationHelper _instance = LocalizationHelper._();
  factory LocalizationHelper() => _instance;

  static final GlobalKey<NavigatorState> _navigatorKey =
      NavigationService.navigatorKey;
  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  static AppLocalizations get tr =>
      AppLocalizations.of(navigatorKey.currentContext!);

  static const String _localeKey = 'app_locale';

  static Locale currentLocale = Locale(
    HiveService.getRaw(boxName: GeneralConstants.appBoxName, key: _localeKey) ??
        AppLocalizations.supportedLocales.first.languageCode,
  );

  static final List<String> localNames = ['العربية', 'English'];
  static final List<String> localIcons = [
    // AppAssets.iconsArFlag,
    // AppAssets.iconsEnFlag,
  ];
  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizations.delegate;

  static String get currentLocalName {
    int index = AppLocalizations.supportedLocales.indexWhere((e) {
      return e.languageCode == currentLocale.languageCode;
    });
    return localNames[index];
  }

  static Future<void> setLocale(String languageName) async {
    int index = localNames.indexOf(languageName);

    await HiveService.putRaw(
      boxName: GeneralConstants.appBoxName,
      key: _localeKey,
      value: AppLocalizations.supportedLocales[index].languageCode,
    );
    LocalizationHelper.currentLocale = AppLocalizations.supportedLocales[index];
  }
}
