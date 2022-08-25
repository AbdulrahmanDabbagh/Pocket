import 'package:flutter/material.dart';
import 'package:money_managment/app/core/utils/app_storage.dart';
import 'package:money_managment/app/core/values/app_colors.dart';

class AppTheme{
  static ThemeData get lightTheme => _lightTheme;
  static ThemeData get darkTheme =>_darkTheme;

  static bool get isDark => AppStorage().read(AppStorage.isDarkTheme) ?? false;
  static ThemeData get theme => isDark?_darkTheme:_lightTheme;

}

final _lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: AppColors.white,
  primaryColor: AppColors.blue,
  colorScheme: ThemeData().colorScheme.copyWith(
    primary: AppColors.blue,
  )
);

final _darkTheme = ThemeData.dark().copyWith(

);