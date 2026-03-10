import 'package:flutter/material.dart';

import '../base_theme.dart';
import 'dark_theme.dart';

class DarkTheme implements BaseTheme {
  @override
  ThemeData get appTheme => darkApplicationTheme;
  @override
  String get name => "dark";

  @override
  Color get primary => const Color(0xFFFFFFFF);
  @override
  Color get btmNavSelectedIconColor => const Color(0xFFFFFFFF);
  @override
  Color get primaryLight => const Color(0xFFFFFFFF);
  @override
  Color get primaryDark => const Color(0xFFFFFFFF);

  @override
  Color get secondary => const Color(0xFF7C83B6);
  @override
  Color get secondaryLight => const Color(0xFF1A2E64);
  @override
  Color get secondaryDark => const Color(0xFF3B3F52);
  @override
  Color get textHint => const Color(0xFF223263);
  @override
  Color get background => const Color(0xFF121212);

  @override
  Color get error => const Color(0xFFE37171);

  @override
  Color get success => const Color(0xFF7ADD86);

  @override
  Color get white => Colors.black;
  @override
  Color get transparent => Colors.transparent;

  @override
  // TODO: implement grey
  Color get grey => const Color(0xFF979898);

  @override
  // TODO: implement greyDark
  Color get greyDark => const Color(0xFFDCDDDD);
  @override
  // TODO: implement greySemiLight
  Color get greySemiLight => const Color(0xFF1E1E1F);
  @override
  // TODO: implement greyExtraDark
  Color get greyExtraDark => const Color(0xFFFDFDFD);

  @override
  // TODO: implement greyExtraDarkWithOpacity
  Color get greyExtraDarkWithOpacity => const Color(0xD5FDFDFD);

  @override
  // TODO: implement greyExtraLight
  Color get greyExtraLight => const Color(0xFF343536);

  @override
  // TODO: implement greyLight
  Color get greyLight => const Color(0xFF565859);

  @override
  // TODO: implement blue
  Color get blue => const Color(0xFF658AF2);

  @override
  // TODO: implement blueExtraLight
  Color get blueExtraLight => const Color(0xFF1A2E64);

  @override
  // TODO: implement blueLight
  Color get blueLight => const Color(0xFF223C83);

  @override
  // TODO: implement orangeExtraLight
  Color get orangeExtraLight => const Color(0xFF684513);

  @override
  // TODO: implement orangeLight
  Color get orangeLight => const Color(0xFF8C5B19);
  @override
  // TODO: implement orangeLight
  Color get orangeDark => const Color(0xff3F2B21);

  @override
  // TODO: implement containerShadow
  Color get containerShadow => const Color(0x663C3C3C); // 40%

  @override
  // TODO: implement defaultButtonShadow
  Color get defaultButtonShadow => const Color(0x17000000); // 9%

  @override
  // TODO: implement defaultContainerShadow
  Color get defaultContainerShadow => const Color(0x26222222); // 15%

  @override
  // TODO: implement defaultStatesBarShadow
  Color get defaultStatesBarShadow => const Color(0x271A1A1A); // 15.3%

  @override
  // TODO: implement progressBackColor
  Color get progressBackColor => const Color(0xFF4B5E70);

  @override
  // TODO: implement black
  Color get black => Colors.white;
  @override
  // TODO: implement black
  Color get lightBlack => const Color(0xFF606268);

  @override
  // TODO: implement blackWithOpacity
  Color get blackWithOpacity => const Color(0x331A1A1A);

  @override
  // TODO: implement green
  Color get green => const Color(0xFF3ECF4F);

  @override
  // TODO: implement greenDark
  Color get greenDark => const Color(0xCF1B5E3D);

  @override
  // TODO: implement greenFaded
  Color get greenFaded => const Color(0xCF72C59C);

  @override
  // TODO: implement greenLight
  Color get greenLight => const Color(0xFF5EFFB8);

  @override
  Color cyan = const Color(0xff00C3FF);

  @override
  Color heavyBlueColor = const Color(0xffffffff);

  @override
  Color red = const Color(0xffF30A0A);

  @override
  Color darkBlue = const Color(0xff2465ae);

  @override
  Color darkRed = const Color(0xffFF2300);

  @override
  Color darkYellow = const Color(0xffFCC046);

  @override
  Color orange = const Color(0xffFF5F00);

  @override
  Color orangeFaded = const Color(0xffffcea1);

  @override
  Color pink = const Color(0xFFF448CD);

  @override
  Color purple = const Color(0xff6100D6);

  @override
  Color redFaded = const Color(0xD2FA7878);

  @override
  Color yellow = const Color(0xffFFF700);
}
