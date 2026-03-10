import 'package:flutter/material.dart';
import '../theme/light_theme.dart';

class FontConstants {
  const FontConstants._();
  static const String fontFamily = "Poppins";
}

class FontWeights {
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
}

/// Naming should be as follows: (font size, font weight, color, text decoration)
class TextStyles {
  TextStyles._();

  // Cached TextStyles
  static TextStyle? _cachedFont14BlackBold;
  static TextStyle? _cachedFont14BlackMedium;
  static TextStyle? _cachedFont16BlackBold;
  static TextStyle? _cachedFont16BlackSemiBold;
  static TextStyle? _cachedFont12BlackLight;
  static TextStyle? _cachedFont12BlackBold;
  static TextStyle? _cachedFont16BlackRegular;
  static TextStyle? _cachedFont16PrimaryRegularUnderlined;
  static TextStyle? _cachedFont18BlackExtraBold;
  static TextStyle? _cachedFont18BlackRegular;
  static TextStyle? _cachedFont18BlackBold;
  static TextStyle? _cachedFont22BlackBlack;

  static TextStyle get font14BlackBold {
    _cachedFont14BlackBold ??= const TextStyle(
      fontSize: 14,
      fontWeight: FontWeights.bold,
      color: Colors.black,
      fontFamily: "Alexandria",
    );
    return _cachedFont14BlackBold!;
  }

  static TextStyle get font14BlackMedium {
    _cachedFont14BlackMedium ??= const TextStyle(
      fontSize: 14,
      fontWeight: FontWeights.medium,
      color: Colors.black,
      fontFamily: "Alexandria",
    );
    return _cachedFont14BlackMedium!;
  }

  static TextStyle get font16BlackBold {
    _cachedFont16BlackBold ??= const TextStyle(
      fontSize: 16,
      fontWeight: FontWeights.bold,
      color: Colors.black,
      fontFamily: "Alexandria",
    );
    return _cachedFont16BlackBold!;
  }

  static TextStyle get font16BlackSemiBold {
    _cachedFont16BlackSemiBold ??= const TextStyle(
      fontSize: 16,
      fontWeight: FontWeights.semiBold,
      color: Colors.black,
      fontFamily: "Alexandria",
    );
    return _cachedFont16BlackSemiBold!;
  }

  static TextStyle get font12BlackLight {
    _cachedFont12BlackLight ??= const TextStyle(
      fontSize: 12,
      fontWeight: FontWeights.light,
      color: Colors.black,
      fontFamily: "Alexandria",
    );
    return _cachedFont12BlackLight!;
  }

  static TextStyle get font12BlackBold {
    _cachedFont12BlackBold ??= const TextStyle(
      fontSize: 12,
      fontWeight: FontWeights.bold,
      color: Colors.black,
      fontFamily: "Alexandria",
    );
    return _cachedFont12BlackBold!;
  }

  static TextStyle get font16BlackRegular {
    _cachedFont16BlackRegular ??= const TextStyle(
      fontSize: 16,
      fontWeight: FontWeights.regular,
      color: Colors.black,
      fontFamily: "Alexandria",
    );
    return _cachedFont16BlackRegular!;
  }

  static TextStyle get font16PrimaryRegularUnderlined {
    _cachedFont16PrimaryRegularUnderlined ??= const TextStyle(
      fontSize: 16,
      fontWeight: FontWeights.regular,
      color: Colors.black,
      decoration: TextDecoration.underline,
      decorationThickness: 3,
      fontFamily: "Alexandria",
    );
    return _cachedFont16PrimaryRegularUnderlined!;
  }

  static TextStyle get font18BlackExtraBold {
    _cachedFont18BlackExtraBold ??= const TextStyle(
      fontSize: 18,
      fontWeight: FontWeights.extraBold,
      color: Colors.black,
      fontFamily: "Alexandria",
    );
    return _cachedFont18BlackExtraBold!;
  }

  static TextStyle get font18BlackRegular {
    _cachedFont18BlackRegular ??= const TextStyle(
      fontSize: 18,
      fontWeight: FontWeights.regular,
      color: Colors.black,
      fontFamily: "Alexandria",
    );
    return _cachedFont18BlackRegular!;
  }

  static TextStyle get font18BlackBold {
    _cachedFont18BlackBold ??= const TextStyle(
      fontSize: 18,
      fontWeight: FontWeights.bold,
      color: Colors.black,
      fontFamily: "Alexandria",
    );
    return _cachedFont18BlackBold!;
  }

  static TextStyle get font20WhiteSemiBold {
    _cachedFont22BlackBlack ??= const TextStyle(
      fontSize: 20, // Fixed incorrect size from 18  to 22
      fontWeight: FontWeights.semiBold,
      color: LightThemeColors.white,
      fontFamily: "Alexandria",
    );
    return _cachedFont22BlackBlack!;
  }

  static TextStyle get font22BlackBlack {
    _cachedFont22BlackBlack ??= const TextStyle(
      fontSize: 22, // Fixed incorrect size from 18  to 22
      fontWeight: FontWeights.black,
      color: Colors.black,
      fontFamily: "Alexandria",
    );
    return _cachedFont22BlackBlack!;
  }

  /// Refresh cached styles when theme changes
  static void refresh() {
    _cachedFont14BlackBold = null;
    _cachedFont14BlackMedium = null;
    _cachedFont16BlackBold = null;
    _cachedFont16BlackSemiBold = null;
    _cachedFont12BlackLight = null;
    _cachedFont12BlackBold = null;
    _cachedFont16BlackRegular = null;
    _cachedFont16PrimaryRegularUnderlined = null;
    _cachedFont18BlackExtraBold = null;
    _cachedFont18BlackRegular = null;
    _cachedFont18BlackBold = null;
    _cachedFont22BlackBlack = null;
  }
}

class FontSize {
  const FontSize._();

  static double s8 = 8.0;
  static double s10 = 10.0;
  static double s11 = 11.0;
  static double s12 = 12.0;
  static double s13 = 13.0;
  static double s14 = 14.0;
  static double s16 = 16.0;
  static double s17 = 17.0;
  static double s18 = 18.0;
  static double s20 = 20.0;
  static double s22 = 22.0;
  static double s24 = 24.0;
  static double s28 = 28.0;
  static double s32 = 32.0;
  static double s40 = 40.0;
  static double s50 = 50.0;
  static double s56 = 56.0;
}
