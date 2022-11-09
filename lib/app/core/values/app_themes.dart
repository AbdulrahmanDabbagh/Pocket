import 'package:flutter/material.dart';
import 'package:money_managment/app/core/utils/app_storage.dart';
import 'package:money_managment/app/core/values/app_colors.dart';
class AppThemeMode{
  Map<String,ThemeData> themeMode = {"Theme mode 1":_lightTheme, "Theme mode 2":_lightTheme2, };

}


class AppTheme{
  static ThemeData get lightTheme => _lightTheme;
  static ThemeData get darkTheme =>_darkTheme;

  static bool get isDark => AppStorage().read(AppStorage.isDarkTheme) ?? false;
  ThemeData get theme => isDark?_darkTheme:_lightTheme;


  ThemeData currentTheme = AppThemeMode().themeMode[AppStorage().read(AppStorage.currentTheme)] ?? AppThemeMode().themeMode["Theme mode 1"]!;
}

Color get cardColor => AppStorage().read(AppStorage.currentTheme) == "Theme mode 1"? AppColors.white:AppColors.blackWithOpacity;
Color get textColor => AppStorage().read(AppStorage.currentTheme) == "Theme mode 1"? Colors.black:AppColors.number4;
Color get textColorNegative => AppStorage().read(AppStorage.currentTheme) == "Theme mode 1"? AppColors.number4:Colors.black;
Color get profileTextColor => AppStorage().read(AppStorage.currentTheme) == "Theme mode 1"? AppColors.blue:AppColors.number4;
Color get barChartColor => AppStorage().read(AppStorage.currentTheme) == "Theme mode 1"? AppColors.blue:AppColors.number4;
Color get floatingActionButtonBackgroundColor => AppStorage().read(AppStorage.currentTheme) == "Theme mode 1"? AppColors.number2:AppColors.number4;
Color get floatingActionButtonIconColor => AppStorage().read(AppStorage.currentTheme) == "Theme mode 1"? AppColors.number4:AppColors.black;
Color get bottomNavigationBarBackgroundColor => AppStorage().read(AppStorage.currentTheme) == "Theme mode 1"? AppColors.white:AppColors.blackWithOpacity;
Color get profileButton => AppStorage().read(AppStorage.currentTheme) == "Theme mode 1"? AppColors.white :AppColors.blackWithOpacity;
Color get bottomNavigationBarnormalIconColor =>AppStorage().read(AppStorage.currentTheme) == "Theme mode 1"? AppColors.number3 :AppColors.number3;
Color get bottomNavigationBarselectedIconColor =>AppStorage().read(AppStorage.currentTheme) == "Theme mode 1"? AppColors.white :AppColors.blue;
Color get bottomNavigationBarIconColor =>AppStorage().read(AppStorage.currentTheme) == "Theme mode 1"? AppColors.number2 :AppColors.number4;
Color get chipSelectedColor =>AppStorage().read(AppStorage.currentTheme) == "Theme mode 1"? AppColors.blue :AppColors.number4;
Color get filterBackgroundColor =>AppStorage().read(AppStorage.currentTheme) == "Theme mode 1"? Colors.white :AppColors.blackWithOpacity2;
Color get textFieldFillColor =>AppStorage().read(AppStorage.currentTheme) == "Theme mode 1"? AppColors.white :AppColors.blackWithOpacity;
Color get textFieldHintStyle =>AppStorage().read(AppStorage.currentTheme) == "Theme mode 1"? AppColors.black :AppColors.number4;
Color get textFieldBoarderColor =>AppStorage().read(AppStorage.currentTheme) == "Theme mode 1"? AppColors.black :AppColors.number4;
Color get dropDownColor =>AppStorage().read(AppStorage.currentTheme) == "Theme mode 1"? AppColors.white :AppColors.black;
Color get chipsBackgroundColor =>AppStorage().read(AppStorage.currentTheme) == "Theme mode 1"? AppColors.gray :AppColors.black;
Color get chipsTextUnselectedColor =>AppStorage().read(AppStorage.currentTheme) == "Theme mode 1"? Colors.black :AppColors.number4;
Color get chipsTextSelectedColor =>AppStorage().read(AppStorage.currentTheme) == "Theme mode 1"? AppColors.white :Colors.black;
Color get searchIconColor =>AppStorage().read(AppStorage.currentTheme) == "Theme mode 1"? Colors.black:AppColors.number4;
Color get menuBackgroundColor =>AppStorage().read(AppStorage.currentTheme) == "Theme mode 1"? AppColors.white:Colors.black;
Color get menuTextColor =>AppStorage().read(AppStorage.currentTheme) == "Theme mode 1"? Colors.black : AppColors.white;
Color get detailsBottomSheetBorderColor =>AppStorage().read(AppStorage.currentTheme) == "Theme mode 1"? AppColors.blue : AppColors.number4;



final _lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: AppColors.white,
  brightness: Brightness.light,
  backgroundColor: AppColors.white,
  primaryColor: AppColors.blue,
  colorScheme: ThemeData().colorScheme.copyWith(
    primary: AppColors.blue,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.white,
    foregroundColor: AppColors.blue
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent
  )
);

final _lightTheme2 = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: Colors.black,
    primaryColor: AppColors.number4,
    colorScheme: ThemeData().colorScheme.copyWith(
      primary: AppColors.number4,
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.number4
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent
    )
);


final _darkTheme = ThemeData.dark().copyWith(

);