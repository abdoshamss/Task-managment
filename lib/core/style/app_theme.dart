import 'package:flutter/material.dart';
import '../data_source/hive_service.dart';
import '../utils/general_constants.dart';
import 'base_theme.dart';
import 'font_styles.dart';
import 'light_mode/light_theme_colors.dart';

BaseTheme get AppColors => AppThemes().theme;

class AppThemes {
  AppThemes._internal();
  static final AppThemes _instance = AppThemes._internal();
  factory AppThemes() => _instance;
  final String themeKey = 'app_theme';

  BaseTheme theme = LightTheme();
  Map<String, BaseTheme> get themes => {'light': LightTheme()};

  void setThemeByName(String name) {
    theme = themes[name] ?? LightTheme();
  }

  void setThemeLocale(BaseTheme value) {
    HiveService.putRaw(
      boxName: GeneralConstants.appBoxName,
      key: themeKey,
      value: value.name,
    );
  }
  // List<BaseTheme> get themes => [LightTheme(), DarkTheme()];

  Future<void> setTheme(BaseTheme baseTheme) async {
    theme = baseTheme;
    setThemeLocale(baseTheme);
  }

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  Theme datePickerTheme(Widget? child) {
    return Theme(
      data: AppColors.appTheme.copyWith(
        colorScheme: AppColors.appTheme.colorScheme.copyWith(
          primary: AppColors.primary,
          onPrimary: AppColors.white,
          surface: AppColors.background,
          onSurface: AppColors.black,
          surfaceTint: AppColors.primary,
        ),
        datePickerTheme: DatePickerThemeData(
          backgroundColor: AppColors.background,
          dayStyle: TextStyles.font16BlackRegular.copyWith(
            fontSize: 14,
            color: AppColors.black,
          ),
          headerHeadlineStyle: TextStyles.font16BlackRegular.copyWith(
            fontSize: 22,
            color: AppColors.white,
          ),
          headerForegroundColor: AppColors.white,
          headerBackgroundColor: AppColors.greyDark,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            textStyle: TextStyles.font16BlackRegular.copyWith(
              fontSize: 14,
              color: AppColors.primary,
            ),
          ),
        ),
        dialogTheme: DialogThemeData(backgroundColor: AppColors.background),
      ),
      child: child ?? const SizedBox(),
    );
  }
}
