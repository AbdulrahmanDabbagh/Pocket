import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:money_managment/app/core/values/app_colors.dart';
import 'package:money_managment/app/core/values/translation/app_translation.dart';
import 'package:money_managment/app/router/app_pages.dart';

import 'app/core/values/app_themes.dart';
import 'app/modules/home/view/home_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      color: AppColors.white,
      getPages: AppPages.pages,
      initialRoute: AppPages.initialRoute,
      translations: AppTranslation(),
      translationsKeys: AppTranslation().keys,
      locale: AppTranslation.currentLocale,
      theme: AppTheme().currentTheme,
      // themeMode: AppTheme.isDark?ThemeMode.dark:ThemeMode.light,
      debugShowCheckedModeBanner: false,
      // builder: (context, child){
      //   return Container(
      //     decoration:  BoxDecoration(
      //       image: DecorationImage(
      //           image: AssetImage("assets/images/wallpaper.jpg"),
      //           fit: BoxFit.cover,
      //           opacity: 1
      //       ),
      //       color: AppColors.white
      //     ),
      //     child: child,
      //   );
      // },
    );
  }
}
