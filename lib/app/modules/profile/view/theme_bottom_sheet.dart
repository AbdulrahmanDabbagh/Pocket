import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_managment/app/core/utils/app_storage.dart';
import 'package:money_managment/app/core/values/app_colors.dart';
import 'package:money_managment/app/core/values/app_themes.dart';

import '../controller/profile_controller.dart';

class ThemeBottomSheet extends GetView<ProfileController> {
  ThemeBottomSheet({Key? key}) : super(key: key);

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  controller.group.value = "Theme mode 1";
                  AppStorage().write(AppStorage.currentTheme, controller.group.value);
                  Get.forceAppUpdate();
                },
                child: Container(
                    height: 75,
                    width: 60,
                    color: AppColors.blue,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 30,
                          height: 40,
                          color: AppColors.white,
                          alignment: Alignment.bottomCenter,
                        ),
                      ],
                    )),
              ),
              SizedBox(
                width: 25,
              ),
              GestureDetector(
                onTap: () {
                  controller.group.value = "Theme mode 2";
                  AppStorage().write(AppStorage.currentTheme, controller.group.value);
                  Get.forceAppUpdate();
                },
                child: Container(
                    height: 75,
                    width: 60,
                    color: AppColors.number4,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 30,
                          height: 40,
                          color: AppColors.black,
                          alignment: Alignment.bottomCenter,
                        ),
                      ],
                    )),
              )
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Radio(
          //         value: "Theme mode 1",
          //         groupValue: controller.group.value,
          //         onChanged: (String? value) {
          //           controller.group.value = value;
          //           AppStorage().write(AppStorage.currentTheme, controller.group.value);
          //           Get.forceAppUpdate();
          //           // AppTheme().currentTheme = AppThemeMode().themeMode[group];
          //         }),
          //     Text("Theme mode 1"),
          //   ],
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Radio(
          //         value: "Theme mode 2",
          //         groupValue: controller.group.value,
          //         onChanged: (String? value) {
          //           controller.group.value = value;
          //           AppStorage().write(AppStorage.currentTheme, controller.group.value);
          //           Get.forceAppUpdate();
          //           print("theme 1");
          //           // AppTheme().currentTheme = AppThemeMode().themeMode[group];
          //         }),
          //     Text("Theme mode 2"),
          //   ],
          // ),
          // RadioListTile<String>(
          //     title: const Text("Theme mode 1"),
          //     value: "Theme mode 1",
          //     groupValue: group,
          //     onChanged: (String? value){
          //       group = value;
          //       AppStorage().write(AppStorage.currentTheme, group);
          //       Get.forceAppUpdate();
          //       // AppTheme().currentTheme = AppThemeMode().themeMode[group];
          //     }),
          // RadioListTile<String>(
          //     title: const Text("Theme mode 2"),
          //     value: "Theme mode 2",
          //     groupValue: group,
          //     onChanged: (String? value){
          //       group = value;
          //       AppStorage().write(AppStorage.currentTheme, group);
          //       Get.forceAppUpdate();
          //       // AppTheme().currentTheme = AppThemeMode().themeMode[group];
          //       setState((){});
          //     }),
        ],
      ),
    );
  }
}
