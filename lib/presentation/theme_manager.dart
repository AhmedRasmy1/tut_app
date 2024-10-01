import 'package:flutter/material.dart';
import 'package:tut_app/presentation/color_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    //main Color
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
  );
}
