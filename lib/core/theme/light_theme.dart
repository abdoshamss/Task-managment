import 'package:flutter/material.dart';

class LightThemeColors {
  const LightThemeColors._();

  // Primary Colors
  static const Color white = Color(0xFFFFFFFF);

  // Secondary Colors
  static const Color secondary = Color(0xFFA7A7A7);

  //   // Surface Colors
  static const Color primaryContainer = Color(0xFFFFFFFF);

  //
  // Background Color
  static const Color scaffoldBackground = Color(0xffFAFBFD);
  static const Color bottomSheetBackground = Colors.white;
  static const Color dialogBackground = Colors.white;
  static const Color background = Colors.white;
  static const Color appBarBackground = background;
  static Color barrierBackground = background.withOpacity(0.53);
  static const secondaryText = Color(0xFF616161);

  // Surface Colors
  static const Color surface = Color(0xFF1E251F);
  static Color surfaceSecondary = const Color(0xFF3C3C3C).withOpacity(0.61);
  static Color surfaceSuccess = const Color(0xFF32E444).withOpacity(0.35);
  static Color surfaceError = LightThemeColors.error.withOpacity(0.35);

  // Text Colors
  // static const Color primaryText = Colors.white;
  // Text Colors
  static const Color textPrimary = Color(0xFF24223E);
  static const Color textSecondary = Color(0xFF8A8C95);
  static const Color textHint = Color(0xFF8A8C95);
  // Text Colors
  static const _primaryValue = 0xFF000000;
  static MaterialColor primaryText = MaterialColor(_primaryValue, <int, Color>{
    10: const Color(_primaryValue).withOpacity(0.1),
    20: const Color(_primaryValue).withOpacity(0.2),
    30: const Color(_primaryValue).withOpacity(0.3),
    40: const Color(_primaryValue).withOpacity(0.4),
    50: const Color(_primaryValue).withOpacity(0.5),
    60: const Color(_primaryValue).withOpacity(0.6),
    70: const Color(_primaryValue).withOpacity(0.7),
    80: const Color(_primaryValue).withOpacity(0.8),
    90: const Color(_primaryValue).withOpacity(0.9),
    100: const Color(_primaryValue),
  });

  // Validation Colors:
  static const Color error = Color(0xFFFF697D);
  static const Color success = Color(0xFF32E444);
  static const Color warning = Color(0xFFE39600);

  // Icons Colors
  static Color unselectedIcon = primaryText[70]!;

  // button Colors
  static const Color buttonColor = Color(0xFF613A96);

  // Icons Colors

  // border Colors
  static const Color border = Color(0xFFA7A7A7);
  static Color inputFieldBorder = primaryText[20]!;
  static const Color borderVariant = Color(0x26A7A7A7);

  // gradient
  static const List<Color> gradientPrimary = [
    Color(0xFF262A2E),
    Color(0xFF131313),
  ];
  // shadow
  static const Color shadow = Color(0x07FFFFFF);
  static const Color shadowVariant = Color(0x0AFFFFFF);
  static Color shadowBottomSheet = Colors.black.withOpacity(0.5);

  // gradient
  static List<Color> gradient = [
    Colors.white,
    // Colors.white.withOpacity(0.5),
    Colors.white.withOpacity(0),
  ];
  static const onPrimaryValue = 0xFFFFFFFF;
  static MaterialColor onPrimary = MaterialColor(onPrimaryValue, <int, Color>{
    10: const Color(onPrimaryValue).withOpacity(0.1),
    20: const Color(onPrimaryValue).withOpacity(0.2),
    30: const Color(onPrimaryValue).withOpacity(0.3),
    40: const Color(onPrimaryValue).withOpacity(0.4),
    50: const Color(onPrimaryValue).withOpacity(0.5),
    60: const Color(onPrimaryValue).withOpacity(0.6),
    70: const Color(onPrimaryValue).withOpacity(0.7),
    80: const Color(onPrimaryValue).withOpacity(0.8),
    90: const Color(onPrimaryValue).withOpacity(0.9),
    100: const Color(onPrimaryValue),
  });
}
