import 'package:flutter/material.dart';

import '../base_theme.dart';

class LightTheme implements BaseTheme {
  @override
  String get name => "light";

  @override
  Color get primary => const Color(0xFFA2C689);
  @override
  Color get primaryLight => const Color(0xFF353744);
  @override
  Color get primaryDark => const Color(0xFF0A0A10);

  @override
  Color get secondary => const Color(0xFF596097);
  @override
  Color get textHint => const Color(0xFF223263);

  @override
  Color get btmNavSelectedIconColor => const Color(0xFF596097);

  @override
  Color get secondaryLight => const Color(0xFFECF0FD);
  @override
  Color get secondaryDark => const Color(0xFF202244);

  @override
  Color get background => const Color(0xffF9F9F9);

  @override
  Color get error => const Color(0xffDB5959);

  @override
  Color get success => const Color(0xff5CB366);

  @override
  Color get white => const Color(0xFFFFFFFF);
  @override
  Color get transparent => Colors.transparent;

  @override
  // TODO: implement grey
  Color get grey => const Color(0xFF979898);

  @override
  // TODO: implement greyDark
  Color get greyDark => const Color(0xff565859);

  @override
  // TODO: implement greyExtraDark
  Color get greyExtraDark => const Color(0xFF2A2C2D);
  @override
  // TODO: implement greySemiLight
  Color get greySemiLight => const Color(0xFFFDFDFD);

  @override
  // TODO: implement greyExtraDarkWithOpacity
  Color get greyExtraDarkWithOpacity => const Color(0xD52A2C2D);

  @override
  // TODO: implement greyExtraLight
  Color get greyExtraLight => const Color(0xFFF6F6F6);

  @override
  // TODO: implement greyLight
  Color get greyLight => const Color(0xFFDCDDDD);

  @override
  // TODO: implement blue
  Color get blue => const Color(0xFF3E6DEF);

  @override
  // TODO: implement blueExtraLight
  Color get blueExtraLight => const Color(0xFFECF0FD);

  @override
  // TODO: implement blueLight
  Color get blueLight => const Color(0xFFC3D2FA);

  @override
  // TODO: implement orangeExtraLight
  Color get orangeExtraLight => const Color(0xFFFFF6EA);

  @override
  // TODO: implement orangeLight
  Color get orangeLight => const Color(0xFFFFE3BE);
  @override
  // TODO: implement orangeLight
  Color get orangeDark => const Color(0xFFFFF6EA);

  @override
  // TODO: implement containerShadow
  Color get containerShadow => const Color(0x66BBBBBB); // 40%

  @override
  // TODO: implement defaultButtonShadow
  Color get defaultButtonShadow => const Color(0x17000000); // 9%

  @override
  // TODO: implement defaultContainerShadow
  Color get defaultContainerShadow => const Color(0x26252526); // 15%

  @override
  // TODO: implement defaultStatesBarShadow
  Color get defaultStatesBarShadow => const Color(0x27000000); // 15.3%

  @override
  // TODO: implement progressBackColor
  Color get progressBackColor => const Color(0x5A7388A9);

  @override
  // TODO: implement black
  Color get black => Colors.black;
  @override
  // TODO: implement black
  Color get lightBlack => const Color(0xFF606268);

  @override
  // TODO: implement blackWithOpacity
  Color get blackWithOpacity => const Color(0x33000000);

  @override
  // TODO: implement green
  Color get green => const Color(0xff21A42E);

  @override
  // TODO: implement greenDark
  Color get greenDark => const Color(0xCF258150);

  @override
  // TODO: implement greenFaded
  Color get greenFaded => const Color(0xCF8AD5AE);

  @override
  // TODO: implement greenLight
  Color get greenLight => const Color(0xFF36FFA5);

  @override
  Color cyan = const Color(0xff00C3FF);

  @override
  Color get heavyBlueColor => const Color(0xff000000);

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

  @override
  ThemeData get appTheme => throw UnimplementedError();
}
