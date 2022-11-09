import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:money_managment/app/modules/onboarding_page/controller/onboarding_page_controller.dart';

import '../../../../core/values/app_colors.dart';
import '../../../../core/values/app_constant.dart';
import '../../../../core/values/app_strings.dart';

class BuildPageBudget extends GetView<OnboardingPageController> {
  const BuildPageBudget({required this.color, required this.urlImage, required this.title, required this.subtitle, Key? key})
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
          const SizedBox(
            height: 64,
          ),
          Text(
            title,
            style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold, fontSize: 32),
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            padding: const EdgeInsets.symmetric(),
            child: Text(
              subtitle,
              style: const TextStyle(color: AppColors.number2),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: AppConstant.pagePadding,
            child: TextFormField(
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstant.radius), borderSide: BorderSide(color: AppColors.number3)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstant.radius), borderSide: BorderSide(color: AppColors.number2)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstant.radius), borderSide: BorderSide(color: AppColors.number2)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstant.radius), borderSide: BorderSide(color: Colors.red)),
                  hintText: AppString.amount.tr,
                  fillColor: AppColors.white,
                  filled: true),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              onChanged: (v) {
                controller.amount = v;
              },
            ),
          )
        ],
      ),
    );
  }
}
