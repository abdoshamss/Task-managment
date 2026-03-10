import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math';
import '../data_source/hive_helper.dart';
import '../data_source/hive_service.dart';
import '../services/media/media_service.dart';
import '../style/app_theme.dart';
import '../style/base_theme.dart';
import '../style/light_mode/light_theme_colors.dart';
import 'general_constants.dart';
import 'locator.dart';
import 'validations.dart';

class Utils {
  static String token = '';
  static String lang = '';
  static String FCMToken = '';
  static String userType = "";
  // static UserModel userModel = UserModel();

  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  static Validation get valid => locator<Validation>();
  static MediaService get media => locator<MediaService>();
  static DataManager get dataManager => locator<DataManager>();

  static Future<void> saveUserInHive(Map<String, dynamic> response) async {
    // userModel = UserModel.fromJson(response);
    // token = userModel.token ?? '';
    // await Utils.dataManager.saveUser(Map<String, dynamic>.from(response));
  }

  static void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  static void fixRtlLastChar(TextEditingController? controller) {
    if (controller != null) {
      if (controller.selection ==
          TextSelection.fromPosition(
            TextPosition(offset: (controller.text.length) - 1),
          )) {
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length),
        );
      }
    }
  }

  static String genrateBarcode() {
    return (Random().nextInt(99999999) + 10000000).toString();
  }

  static double getSizeOfFile(File file) {
    final size = file.readAsBytesSync().lengthInBytes;
    final kb = size / 1024;
    final mb = kb / 1024;
    print(mb);
    return mb;
  }

  String themeName = 'light';
  static BaseTheme get themeMode =>
      AppThemes().themes[_themeMode.name] ?? _themeMode;
  static BaseTheme _themeMode = LightTheme();

  static Future<void> initTheme() async {
    final themeName =
        await HiveService.getRaw(
          boxName: GeneralConstants.appBoxName,
          key: AppThemes().themeKey,
        ) ??
        LightTheme().name;
    _themeMode = AppThemes().themes[themeName] ?? LightTheme();
    AppThemes().setTheme(_themeMode);
  }
}
