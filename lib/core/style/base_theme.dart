import 'package:flutter/material.dart';

abstract class BaseTheme {
  String get name;
  ThemeData get appTheme;

  Color get primary;
  Color get primaryLight;
  Color get primaryDark;

  Color get secondary;
  Color get secondaryLight;
  Color get secondaryDark;

  Color get textHint;

  Color get background;
  Color get error;
  Color get success;

  Color get btmNavSelectedIconColor;

  Color get white;
  Color get transparent => Colors.transparent;

  Color get greyExtraLight;
  Color get greyLight;
  Color get greySemiLight;
  Color get greyDark;
  Color get greyExtraDark;
  Color get greyExtraDarkWithOpacity;
  Color get grey;

  Color get blueExtraLight;
  Color get blueLight;
  Color get blue;

  Color get orangeExtraLight;
  Color get orangeLight;
  Color get orangeDark;

  Color get progressBackColor;
  Color get containerShadow;
  Color get defaultButtonShadow;
  Color get defaultContainerShadow;
  Color get defaultStatesBarShadow;
  Color get black;
  Color get lightBlack;
  Color get blackWithOpacity;

  Color get green;
  Color get greenLight;
  Color get greenFaded;
  Color get greenDark;
  Color get heavyBlueColor;

  Color darkRed = const Color(0xffFF2300);
  Color orange = const Color(0xffFF5F00);
  Color orangeFaded = const Color(0xffffcea1);
  Color cyan = const Color(0xff00C3FF);
  Color darkBlue = const Color(0xff2465ae);
  Color red = const Color(0xffF30A0A);
  Color redFaded = const Color(0xD2FA7878);
  Color pink = const Color(0xFFF448CD);
  Color darkYellow = const Color(0xffFCC046);
  Color yellow = const Color(0xffFFF700);
  Color purple = const Color(0xff6100D6);
}
