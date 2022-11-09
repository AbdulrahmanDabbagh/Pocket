import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_storage.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/app_constant.dart';
import '../../../../core/values/app_strings.dart';
import '../../controller/onboarding_page_controller.dart';

class BuildPagePassword extends GetView<OnboardingPageController> {
  const BuildPagePassword({required this.color, required this.urlImage, required this.title, required this.subtitle, Key? key})
      : super(key: key);
  final bool textFormField = false;
  final Color color;
  final String urlImage;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.addForm,
      child: Container(
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
              child: ElevatedButton(
                onPressed: () {
                  if (AppStorage().read(AppStorage.hasPassword) == true) {
                    Get.dialog(Dialog(
                      child: Padding(
                        padding: AppConstant.pagePadding,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(AppString.doYouWantToDeletePassword.tr),
                            const SizedBox(
                              height: AppConstant.paddingValue,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        AppStorage().write(AppStorage.hasPassword, false);
                                        Get.forceAppUpdate();
                                        Get.back();
                                      },
                                      child: Text(AppString.yes.tr)),
                                ),
                                const Spacer(),
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text(AppString.no.tr)),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ));
                  } else {
                    Get.dialog(Dialog(
                      child: Padding(
                        padding: AppConstant.pagePadding,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(AppString.doYouWantToAddPassword.tr),
                            const SizedBox(
                              height: AppConstant.paddingValue,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                        screenLock(
                                          context: Get.overlayContext!,
                                          correctString: "",
                                          digits: 6,
                                          canCancel: true,
                                          confirmation: true,
                                          didConfirmed: (value){
                                            AppStorage().write(AppStorage.hasPassword, true);
                                            AppStorage().write(AppStorage.pinCode, value);
                                            AppStorage().write(AppStorage.digits, 6);
                                            print(value);
                                            Get.back();
                                          },
                                          // customizedButtonChild: Icon(
                                          //   Icons.fingerprint,
                                          // ),
                                          // customizedButtonTap: () async {
                                          //   print("customizedButtonTap");
                                          //   if(await localAuth(Get.overlayContext!))
                                          //   {
                                          //     Get.back();
                                          //   }
                                          // },
                                          // didOpened: () async {
                                          //   print("didOpened");
                                          //   await localAuth(Get.overlayContext!);
                                          // },
                                        );
                                        // Get.dialog(Dialog(
                                        //   child: Padding(
                                        //     padding: AppConstant.pagePadding,
                                        //     child: Column(
                                        //       mainAxisSize: MainAxisSize.min,
                                        //       children: [
                                        //         TextFormField(
                                        //           decoration: InputDecoration(
                                        //               focusedBorder: OutlineInputBorder(
                                        //                   borderRadius: BorderRadius.circular(AppConstant.radius),
                                        //                   borderSide: BorderSide(color: AppColors.number3)),
                                        //               enabledBorder: OutlineInputBorder(
                                        //                   borderRadius: BorderRadius.circular(AppConstant.radius),
                                        //                   borderSide: BorderSide(color: AppColors.number2)),
                                        //               border: OutlineInputBorder(
                                        //                   borderRadius: BorderRadius.circular(AppConstant.radius),
                                        //                   borderSide: BorderSide(color: AppColors.number2)),
                                        //               errorBorder: OutlineInputBorder(
                                        //                   borderRadius: BorderRadius.circular(AppConstant.radius),
                                        //                   borderSide: BorderSide(color: Colors.red)),
                                        //               hintText: AppString.password.tr,
                                        //               fillColor: AppColors.white,
                                        //               filled: true),
                                        //           inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                        //           keyboardType: TextInputType.number,
                                        //           onChanged: (v) => controller.password = v,
                                        //           validator: (String? value) {
                                        //             if (value == null || value.isEmpty) {
                                        //               return AppString.required.tr;
                                        //             }
                                        //             return null;
                                        //           },
                                        //         ),
                                        //         ElevatedButton(
                                        //           onPressed: () {
                                        //             if (controller.addForm.currentState!.validate()) {
                                        //               AppStorage().write(AppStorage.hasPassword, true);
                                        //               AppStorage().write(AppStorage.pinCode, controller.password);
                                        //               print("ttttttttttttt");
                                        //               AppStorage().write(AppStorage.digits, controller.password.toString().length);
                                        //               Get.back();
                                        //             }
                                        //           },
                                        //           child: Text(AppString.save.tr),
                                        //         )
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ));
                                      },
                                      child: Text(AppString.yes.tr)),
                                ),
                                Spacer(),
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text(AppString.no.tr)),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ));
                  }
                },
                style:
                    ElevatedButton.styleFrom(padding: AppConstant.pagePadding, onPrimary: AppColors.blue, primary: AppColors.white),
                child: Row(
                  children: [
                    Icon(Icons.password),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(AppString.password.tr, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
