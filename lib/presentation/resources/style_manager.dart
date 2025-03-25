import 'package:flutter/material.dart';
import 'package:meal_tracking_app/presentation/resources/color_manager.dart';
import 'package:meal_tracking_app/presentation/resources/font_manager.dart';
import 'package:meal_tracking_app/presentation/resources/size_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      decoration: TextDecoration.none);
}

TextStyle AppBarTextStyle(
    {double fontSize = AppSize.s24, Color color = ColorManager.primary}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}

//medium style
TextStyle getheadlineLarge(
    {double fontSize = AppSize.s26, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}

//bold style
TextStyle getheadlineMedium(
    {double fontSize = AppSize.s20, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
}

//semibold style
TextStyle getBodyLarge({double fontSize = AppSize.s18, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}

TextStyle getBodyMedium({double fontSize = AppSize.s18, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}

TextStyle getDisplayMedium(
    {double fontSize = AppSize.s14, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color);
}

TextStyle getTitleLarge({double fontSize = AppSize.s20, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
}
