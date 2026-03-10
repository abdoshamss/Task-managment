import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../font_styles.dart';

ThemeData get darkApplicationTheme {
  return ThemeData(
    useMaterial3: true,

    // main colors
    primaryColor: AppColors.primaryDark,
    canvasColor: AppColors.greyExtraDark,
    primarySwatch: AppThemes().createMaterialColor(AppColors.primaryDark),
    fontFamily: AppFonts.defaultFont,
    primaryColorLight: AppColors.primary,
    primaryColorDark: AppColors.primaryDark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    disabledColor: AppColors.grey,
    splashColor: AppColors.primary.withOpacity(0.3),
    highlightColor: AppColors.primary.withOpacity(0.1),
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryDark,
      primary: AppColors.primaryDark,
      secondary: AppColors.secondaryDark,
      // onPrimary: AppColors.greyExtraDark, // header text color
      // onPrimaryContainer: AppColors.greyExtraDark, // body text color
      // onSecondary: AppColors.greyExtraDark,
      // background: AppColors.greyExtraDark,
      // onBackground: AppColors.white, // body text color
      // surface: AppColors.greyExtraDark,
      // surfaceTint: AppColors.greyExtraDark,
      // onSurface: AppColors.primaryDark, // body text color
      // onSurfaceVariant: AppColors.white, // EX: range picker text color
    ),
    datePickerTheme: DatePickerThemeData(
      headerBackgroundColor: AppColors.primary,
      headerForegroundColor: AppColors.white,
      rangePickerHeaderForegroundColor: AppColors.heavyBlueColor,
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: TextStyle(fontSize: 18),
        // floatingLabelStyle: defaultTextStyle(fontSize: 18.sp),
        // labelStyle: defaultTextStyle(),
        // prefixIconColor: ThemeConstants.defaultMaterialStateColor(),
        // suffixIconColor: ThemeConstants.defaultMaterialStateColor(),
        // isCollapsed: true,
        // isDense: true,
        fillColor: AppColors.white,
        filled: true,
        errorMaxLines: 2,
        // floatingLabelBehavior: FloatingLabelBehavior.never,
        // alignLabelWithHint: true,
        // floatingLabelAlignment: FloatingLabelAlignment.start,
        focusColor: AppColors.primaryDark,
        // content padding
        contentPadding: const EdgeInsetsDirectional.fromSTEB(10, 6, 10, 6),
        // hint style
        hintStyle: TextStyles.font14BlackMedium.copyWith(
          color: AppColors.greyExtraDarkWithOpacity,
        ),
        // labelStyle: TextStyles.font16BlackRegular.copyWith(color: AppColors.primary, fontSize: 14.sp),
        // errorStyle: TextStyles.font16BlackRegular.copyWith(color: AppColors.error, fontSize: 12.sp),
        // helperStyle: TextStyles.font12BlackLight.copyWith(),
        activeIndicatorBorder: BorderSide(color: AppColors.grey),
        outlineBorder: BorderSide(color: AppColors.grey),
        // border: ThemeConstants.defaultInputBorder(
        //   borderColor: AppColors.greyLight,
        // ),
        // disabledBorder: ThemeConstants.defaultInputBorder(
        //   borderColor: AppColors.greyLight,
        //   borderRadius: BorderRadius.circular(12),
        // ),
        // enabledBorder: ThemeConstants.defaultInputBorder(
        //   borderColor: AppColors.greyLight,
        //   borderRadius: BorderRadius.circular(12),
        // ),
        // focusedBorder: ThemeConstants.defaultInputBorder(
        //   borderColor: AppColors.greyLight,
        //   borderRadius: BorderRadius.circular(12),
        // ),
        // focusedErrorBorder: ThemeConstants.defaultInputBorder(
        //   borderColor: AppColors.error,
        //   shadowColor: AppColors.error.withOpacity(0.4),
        // ),
        // errorBorder: ThemeConstants.defaultInputBorder(
        //   borderColor: AppColors.error.withOpacity(0.4),
        //   shadowColor: AppColors.error.withOpacity(0.4),
        // ),
      ),
    ),
    dividerTheme: DividerThemeData(color: AppColors.greyDark, space: 16),
    // ripple effect color
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStateProperty.all(AppColors.primaryDark),
      trackColor: WidgetStateProperty.all(AppColors.greyExtraDark),
    ),
    // cardview theme
    cardTheme: CardThemeData(
      color: AppColors.greyDark,
      surfaceTintColor: AppColors.greyDark,
      shadowColor: AppColors.containerShadow,
      elevation: 3,
    ), // app bar theme
    appBarTheme: AppBarTheme(
      surfaceTintColor: AppColors.greyExtraDark,
      backgroundColor: AppColors.greyExtraDark,
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: AppColors.primary,
      backgroundColor: AppColors.greyExtraDark,
      height: 65,
      surfaceTintColor: AppColors.greyExtraDark,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      indicatorShape: CircleBorder(side: BorderSide(color: AppColors.primary)),
      elevation: 10,
    ),

    // Tab Bar
    tabBarTheme: TabBarThemeData(
      labelPadding: const EdgeInsets.symmetric(horizontal: 8),
      labelColor: AppColors.primaryDark,
      dividerColor: AppColors.transparent,
      labelStyle: TextStyles.font14BlackBold.copyWith(
        fontFamily: AppFonts.defaultFont,
      ),
      indicatorColor: AppColors.primaryDark,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.primaryDark, width: 2),
        ),
      ),
      unselectedLabelColor: AppColors.grey,
      overlayColor: WidgetStateProperty.all(AppColors.greyDark),
      unselectedLabelStyle: TextStyles.font14BlackMedium.copyWith(
        fontFamily: AppFonts.defaultFont,
        color: AppColors.grey,
      ),
    ),
    // Button themes
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      disabledColor: AppColors.greyDark,
      buttonColor: AppColors.primaryDark,
    ),
    iconButtonTheme: IconButtonThemeData(
      // style: ButtonStyle(iconColor: ThemeConstants.defaultMaterialStateColor()),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: AppColors.primaryDark),
          ),
        ),
        foregroundColor: WidgetStateProperty.all(AppColors.white),
        shadowColor: WidgetStateProperty.all(
          AppColors.primary.withOpacity(0.1),
        ),
        elevation: WidgetStateProperty.all(2),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.white,
      surfaceTintColor: AppColors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    radioTheme: RadioThemeData(
      // fillColor: ThemeConstants.defaultMaterialStateColor(
      //   iconColor: AppColors.primary,
      // ),
    ),
    checkboxTheme: CheckboxThemeData(
      // fillColor: ThemeConstants.defaultMaterialStateColor(
      //   iconColor: AppColors.primary,
      // ),
      // checkColor: ThemeConstants.defaultMaterialStateColor(
      //   iconColor: AppColors.white,
      // ),
    ),
    // text theme
    textTheme: TextTheme(
      // bodyLarge: ThemeConstants.defaultTextStyle(
      //   fontSize: 16,
      //   color: AppColors.white,
      // ),
    ),
    iconTheme: IconThemeData(
      size: 24,
      // color: ThemeConstants.defaultMaterialStateColor(
      //   iconColor: AppColors.grey,
      // ),
    ),
    // input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: TextStyle(fontSize: 18),
      // prefixIconColor: ThemeConstants.defaultMaterialStateColor(),
      // suffixIconColor: ThemeConstants.defaultMaterialStateColor(),
      fillColor: AppColors.white,
      filled: true,
      errorMaxLines: 2,
      focusColor: AppColors.primary,
      contentPadding: const EdgeInsetsDirectional.fromSTEB(10, 6, 10, 6),
      hintStyle: TextStyles.font14BlackMedium.copyWith(
        color: AppColors.greyExtraDarkWithOpacity,
      ),
      activeIndicatorBorder: BorderSide(color: AppColors.greyDark),
      outlineBorder: BorderSide(color: AppColors.greyDark),
      // border: ThemeConstants.defaultInputBorder(
      //   borderColor: AppColors.greyDark,
      // ),
      // disabledBorder: ThemeConstants.defaultInputBorder(
      //   borderColor: AppColors.greyDark,
      //   borderRadius: BorderRadius.circular(12),
      // ),
      // enabledBorder: ThemeConstants.defaultInputBorder(
      //   borderColor: AppColors.greyDark,
      //   borderRadius: BorderRadius.circular(12),
      // ),
      // focusedBorder: ThemeConstants.defaultInputBorder(
      //   borderColor: AppColors.greyDark,
      //   borderRadius: BorderRadius.circular(12),
      // ),
      // focusedErrorBorder: ThemeConstants.defaultInputBorder(
      //   borderColor: AppColors.error,
      //   shadowColor: AppColors.error.withOpacity(0.4),
      // ),
      // errorBorder: ThemeConstants.defaultInputBorder(
      //   borderColor: AppColors.error.withOpacity(0.4),
      //   shadowColor: AppColors.error.withOpacity(0.4),
      // ),
    ),
  );
}
