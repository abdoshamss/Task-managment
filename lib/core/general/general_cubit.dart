import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../localization/localization_helper.dart';
import '../style/app_theme.dart';
import '../style/dark_mode/dark_theme_colors.dart';
import '../style/light_mode/light_theme_colors.dart';

part 'general_state.dart';

class GeneralCubit extends Cubit<GeneralState> {
  GeneralCubit() : super(GeneralInitial());
  static GeneralCubit get(context) => BlocProvider.of(context);

  //change app theme
  bool get isLightMode => AppThemes().theme.name == 'light';

  void changeAppTheme() {
    final newTheme = isLightMode ? DarkTheme() : LightTheme();
    AppThemes().setTheme(newTheme);
    emit(GeneralChangeAppTheme());
  }

  void changeLocale(String localeName) {
    if (LocalizationHelper.currentLocalName == localeName) return;

    LocalizationHelper.setLocale(localeName);
    emit(GeneralChangeLocale(locale: LocalizationHelper.currentLocalName));
    // NavigationService.pushNamedReplaceAll();
  }
}
