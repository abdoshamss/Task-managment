import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../font_styles.dart';

ThemeData get lightApplicationTheme {
  return ThemeData(
    useMaterial3: true,
    // main colors
    primaryColor: AppColors.primary,
    canvasColor: AppColors.white,
    // primarySwatch: AppThemes().createMaterialColor(AppColors.primary),
    fontFamily: AppFonts.defaultFont,
    primaryColorLight: AppColors.primaryLight,
    primaryColorDark: AppColors.primaryDark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    disabledColor: AppColors.greyExtraDark,
    splashColor: AppColors.primaryLight.withOpacity(0.3),
    highlightColor: AppColors.primaryLight.withOpacity(0.1),
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      // onPrimary: AppColors.white, // header text color
      // onPrimaryContainer: AppColors.white, // body text color
      // onSecondary: AppColors.white,
      // surface: AppColors.white,
      // background: AppColors.background,
      // onBackground: AppColors.black, // body text color
      // surface: AppColors.white,
      // surfaceTint: AppColors.white,
      // onSurface: AppColors.primary, // body text color
      // onSurfaceVariant: AppColors.black, // EX: range picker text color
    ),
    datePickerTheme: DatePickerThemeData(
      headerBackgroundColor: AppColors.primary,
      headerForegroundColor: AppColors.white,
      rangePickerHeaderForegroundColor: AppColors.heavyBlueColor,
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: TextStyle(fontSize: 18),
        // floatingLabelStyle: defaultTextStyle(fontSize: 18.sp),
        // labelStyle: defaultTextStyle(),
        // prefixIconColor: ThemeConstants.defaultMaterialStateColor(
        //   iconColor: AppColors.black,
        // ),
        // suffixIconColor: ThemeConstants.defaultMaterialStateColor(
        //   iconColor: AppColors.black,
        // ),
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

    dividerTheme: DividerThemeData(color: AppColors.greyLight, space: 16),
    // ripple effect color
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStateProperty.all(AppColors.primary),
      trackColor: WidgetStateProperty.all(AppColors.white),
    ),
    // cardview theme
    cardTheme: CardThemeData(
      color: AppColors.grey,
      surfaceTintColor: AppColors.grey,
      shadowColor: AppColors.containerShadow,
      elevation: 3,
    ),
    // app bar theme
    appBarTheme: AppBarTheme(
      // toolbarHeight: 90.sp,
      surfaceTintColor: AppColors.greySemiLight,
      backgroundColor: AppColors.greySemiLight,
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: AppColors.primaryLight,
      backgroundColor: AppColors.white,
      height: 65,
      surfaceTintColor: AppColors.white,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      indicatorShape: CircleBorder(
        side: BorderSide(color: AppColors.primaryLight),
      ),
      elevation: 10,
      // landscapeLayout: BottomNavigationBarLandscapeLayout.spread
    ),
    // Tab Bar
    tabBarTheme: TabBarThemeData(
      labelPadding: const EdgeInsets.symmetric(horizontal: 8),
      labelColor: AppColors.primary,
      dividerColor: AppColors.transparent,
      labelStyle: TextStyles.font14BlackBold.copyWith(
        fontFamily: AppFonts.defaultFont,
      ),
      indicatorColor: AppColors.primary,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.primary, width: 2)),
      ),
      unselectedLabelColor: AppColors.greyDark,
      overlayColor: WidgetStateProperty.all(AppColors.greyLight),
      unselectedLabelStyle: TextStyles.font14BlackMedium.copyWith(
        fontFamily: AppFonts.defaultFont,
        // color: AppColors.greyDark,
      ),
    ),
    // Button themes
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      disabledColor: AppColors.greyLight,
      buttonColor: AppColors.primary,
      // splashColor: AppColors.primaryLight,
    ),
    // iconButtonTheme: IconButtonThemeData(
    //   style: ButtonStyle(
    //     // shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8).r,)),
    //     iconColor: ThemeConstants.defaultMaterialStateColor(),
    //   ),
    // ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: AppColors.primary),
          ),
        ),
        // backgroundColor: MaterialStateProperty.all(AppColors.action),
        foregroundColor: WidgetStateProperty.all(AppColors.white),
        shadowColor: WidgetStateProperty.all(
          AppColors.primaryDark.withOpacity(0.1),
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
        // textStyle: TextStyles.font16BlackBold.copyWith(color: AppColors.white, fontSize: 14.sp),
        // backgroundColor: AppColors.action,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    radioTheme: RadioThemeData(
      // fillColor: ThemeConstants.defaultMaterialStateColor(
      //   iconColor: AppColors.primaryDark,
      // ),
    ),
    // text theme
    textTheme: TextTheme(
      // displayLarge:
      //     getExtraBoldStyle(color: AppColors.black, fontSize: 20.sp, height: 2),
      // displayMedium:
      //     getSemiBoldStyle(color: AppColors.black, fontSize: 18.sp, height: 2),
      // displaySmall:
      //     getSemiBoldStyle(color: AppColors.black, height: 2),
      // headlineLarge:
      //     getSemiBoldStyle(color: AppColors.black, fontSize: 18.sp, height: 2),
      // headlineMedium:
      //     getSemiBoldStyle(color: AppColors.black, height: 2),
      // headlineSmall:
      //     getSemiBoldStyle(color: AppColors.black, fontSize: 14.sp, height: 2),
      // titleLarge: TextStyles.font16BlackBold.copyWith(color: AppColors.black),
      // titleMedium: TextStyles.font16BlackBold.copyWith(color: AppColors.black, fontSize: 14.sp),
      // titleSmall: TextStyles.font16BlackBold.copyWith(color: AppColors.black, fontSize: 10.sp),
      // //Input Field Text
      // bodyLarge: ThemeConstants.defaultTextStyle(
      //   fontSize: 16.sp,
      //   color: AppColors.black,
      // ),
      // bodyMedium: TextStyles.font16BlackRegular.copyWith(color: AppColors.black),
      // bodySmall: TextStyles.font16BlackRegular.copyWith(color: AppColors.black, fontSize: 12.sp),
      // labelLarge: TextStyles.font16BlackRegular.copyWith(color: AppColors.primary),
      // labelMedium: TextStyles.font16BlackRegular.copyWith(color: AppColors.primary),
      // labelSmall: TextStyles.font16BlackRegular.copyWith(color: AppColors.black, fontSize: 12.sp),
    ),
    iconTheme: IconThemeData(
      size: 24,
      // color: ThemeConstants.defaultMaterialStateColor(
      //   iconColor: AppColors.greyDark,
      // ),
    ),
    // input decoration theme (text form field)
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
    // label style
    // switch style
    // switchTheme: SwitchThemeData(
    //   thumbColor: MaterialStateProperty.all(AppColors.white),
    //   trackColor: MaterialStateProperty.all(AppColors.primary),
    //   overlayColor: MaterialStateProperty.all(AppColors.greyLight),
    // ),
  );
}
