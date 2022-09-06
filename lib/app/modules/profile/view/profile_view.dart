import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_managment/app/core/values/app_colors.dart';

import '../../../core/values/app_constant.dart';
import '../../../core/values/app_strings.dart';
import '../../../core/values/translation/app_translation.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConstant.pagePadding,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(Icons.sunny),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    AppString.theme.tr,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )
                ],
              ),
              style:
              ElevatedButton.styleFrom(padding: AppConstant.pagePadding, onPrimary: AppColors.blue, primary: AppColors.white)
            ),
            const SizedBox(height: AppConstant.paddingValue),
            ElevatedButton(
              onPressed: () {
                final locale = AppTranslation.isArabic ? AppTranslation.englishLocale : AppTranslation.arabicLocale;
                Get.locale = locale;
                AppTranslation.saveLocale(locale);
                Get.forceAppUpdate();
              },
              child: Row(
                children: [
                  Icon(Icons.language),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(AppString.Language.tr, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                ],
              ),
              style:
              ElevatedButton.styleFrom(padding: AppConstant.pagePadding, onPrimary: AppColors.blue, primary: AppColors.white)
            ),
            const SizedBox(height: AppConstant.paddingValue),
            ElevatedButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(Icons.password),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(AppString.password.tr, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                ],
              ),
              style:
                  ElevatedButton.styleFrom(padding: AppConstant.pagePadding, onPrimary: AppColors.blue, primary: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
