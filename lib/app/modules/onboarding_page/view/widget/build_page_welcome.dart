import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_managment/app/core/values/app_strings.dart';
import 'package:money_managment/app/modules/onboarding_page/controller/onboarding_page_controller.dart';

import '../../../../core/values/app_colors.dart';
import '../../../../core/values/app_constant.dart';
import '../../../../core/values/translation/app_translation.dart';

class BuildPageWelcome extends GetView<OnboardingPageController> {
  const BuildPageWelcome({required this.color, required this.urlImage, required this.title, required this.subtitle, Key? key})
      : super(key: key);
  final bool textFormField = false;
  final Color color;
  final String urlImage;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            urlImage,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          const SizedBox(height: 64,),
          Padding(
            padding: AppConstant.pagePadding,
            child: Text(
              title,
              style: TextStyle(
                  color: AppColors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  height: 0.8
              ),
            ),
          ),
          const SizedBox(height: 24,),
          Padding(
            padding: AppConstant.pagePadding,
            child: Text(
              subtitle,
              style: const TextStyle(color: AppColors.number2,height: 0.8),
            ),
          ),
          const SizedBox(height: 24,),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: AppConstant.pagePadding,
                  child: ElevatedButton(
                      onPressed: () {
                        final locale = AppTranslation.isArabic ? AppTranslation.englishLocale : AppTranslation.arabicLocale;
                        Get.locale = locale;
                        AppTranslation.saveLocale(locale);
                        Get.forceAppUpdate();
                      },
                      style:
                      ElevatedButton.styleFrom(padding: AppConstant.pagePadding, onPrimary: AppColors.blue, primary: AppColors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.language),
                          SizedBox(width: 15,),
                          Text(AppString.Language.tr),
                        ],
                      )
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
