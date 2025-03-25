import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meal_tracking_app/presentation/resources/color_manager.dart';
import 'package:meal_tracking_app/presentation/resources/size_manager.dart';
import 'package:meal_tracking_app/presentation/resources/style_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    scaffoldBackgroundColor: ColorManager.white,
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primary,
    primaryColorDark: ColorManager.primary,
    disabledColor: ColorManager.grey,
    splashColor: ColorManager.lightGrey,
    //

    cardTheme: CardTheme(
        color: ColorManager.white,
        elevation: AppSize.s8,
        shadowColor: ColorManager.lightGrey),

    appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        color: ColorManager.white,
        shadowColor: ColorManager.lightGrey,
        centerTitle: true,
        titleTextStyle: AppBarTextStyle(),
        elevation: AppSize.s4),
    //
    textTheme: TextTheme(
        titleLarge: getTitleLarge(color: ColorManager.primary),
        headlineLarge: getheadlineLarge(color: ColorManager.secondary),
        headlineMedium: getheadlineMedium(color: ColorManager.primary),
        bodyLarge: getBodyLarge(color: ColorManager.darkGrey),
        bodyMedium: getBodyMedium(color: ColorManager.secondary),
        displayMedium: getDisplayMedium(color: ColorManager.grey)),

    //
    inputDecorationTheme: InputDecorationTheme(
        // prefixIconColor: ColorManager.lightGrey,
        prefixIconColor: ColorManager.secondary,

        // contentPadding: const EdgeInsets.all(AppPadding.p8),
        hintStyle: getBodyMedium(color: ColorManager.grey),
        labelStyle: getBodyMedium(color: ColorManager.primary),
        errorStyle: getDisplayMedium(color: ColorManager.error),
        helperStyle: getBodyMedium(color: ColorManager.black),
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.secondary, width: AppSize.s1),
            borderRadius: BorderRadius.circular(AppSize.s8)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1),
            borderRadius: BorderRadius.circular(AppSize.s8)),
        errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.error, width: AppSize.s1),
            borderRadius: BorderRadius.circular(AppSize.s8)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.primary, width: AppSize.s1),
            borderRadius: BorderRadius.circular(AppSize.s8))),
    //
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            elevation: AppSize.s4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s8)),
            backgroundColor: ColorManager.white,
            textStyle: getBodyLarge(color: ColorManager.primary))),

    //
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorManager.white,
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        type: BottomNavigationBarType.shifting,
        selectedLabelStyle: getBodyLarge(color: ColorManager.secondary),
        elevation: AppSize.s12,
        unselectedItemColor: ColorManager.grey,
        selectedItemColor: ColorManager.secondary),

    snackBarTheme: SnackBarThemeData(
        backgroundColor: ColorManager.lightGrey,
        showCloseIcon: true,
        elevation: AppSize.s16,
        contentTextStyle: getBodyLarge(color: ColorManager.black)),
    dialogTheme: DialogTheme(
        backgroundColor: ColorManager.white,
        elevation: AppSize.s16,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s8))),

    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: ColorManager.white,
      refreshBackgroundColor: ColorManager.lightGrey,
      circularTrackColor: ColorManager.secondary,
    ),
  );
}
