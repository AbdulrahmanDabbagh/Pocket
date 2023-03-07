import 'package:flutter/material.dart';

import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:get/get.dart';
import 'package:money_managment/app/components/confirm_operation_dialog.dart';
import 'package:money_managment/app/core/utils/app_storage.dart';
import 'package:money_managment/app/core/values/app_colors.dart';
import 'package:money_managment/app/core/values/app_themes.dart';
import 'package:money_managment/app/modules/profile/view/theme_bottom_sheet.dart';
import 'package:money_managment/app/modules/splash/controller/splash_controller.dart';

import '../../../../main.dart';
import '../../../core/values/app_constant.dart';
import '../../../core/values/app_strings.dart';
import '../../../core/values/translation/app_translation.dart';
import '../controller/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);

  final controller = Get.put(ProfileController());
  final splashController = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.addForm,
      child: Padding(
        padding: AppConstant.pagePadding,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.bottomSheet(ThemeBottomSheet());
                  },
                  style: ElevatedButton.styleFrom(
                      padding: AppConstant.pagePadding, onPrimary: profileTextColor, primary: profileButton),
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
                  )),
              const SizedBox(height: AppConstant.paddingValue),
              ElevatedButton(
                  onPressed: () {
                    final locale = AppTranslation.isArabic ? AppTranslation.englishLocale : AppTranslation.arabicLocale;
                    Get.locale = locale;
                    AppTranslation.saveLocale(locale);
                    Get.forceAppUpdate();
                  },
                  style: ElevatedButton.styleFrom(
                      padding: AppConstant.pagePadding, onPrimary: profileTextColor, primary: profileButton),
                  child: Row(
                    children: [
                      Icon(Icons.language),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(AppString.Language.tr, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                    ],
                  )),
              const SizedBox(height: AppConstant.paddingValue),
              ElevatedButton(
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
                                          didConfirmed: (value) {
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
                style: ElevatedButton.styleFrom(
                    padding: AppConstant.pagePadding, onPrimary: profileTextColor, primary: profileButton),
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
              const SizedBox(height: AppConstant.paddingValue),
              ElevatedButton(
                  onPressed: () {
                    Get.dialog(ConfirmOperationDialog(
                        onConfirm: () {
                          if (AppStorage().read(AppStorage.hasPassword) == true) {
                            screenLock(
                              context: Get.overlayContext!,
                              correctString: AppStorage().read(AppStorage.pinCode),
                              digits: AppStorage().read(AppStorage.digits),
                              canCancel: true,
                              // confirmation: true,
                              // didConfirmed: (value){
                              //   db.deleteAllCategoriesRow();
                              //   db.deleteAllDebtorAndCreditorRow();
                              //   db.deleteAllFutureGoalsRow();
                              //   db.deleteAllOperationRow();
                              //   Get.back();
                              //   Get.forceAppUpdate();
                              // },
                              customizedButtonChild: Icon(
                                Icons.fingerprint,
                              ),
                              customizedButtonTap: () async {
                                print("customizedButtonTap");
                                if (await splashController.localAuth(Get.overlayContext!)) {
                                  db.deleteAllCategoriesRow();
                                  db.deleteAllDebtorAndCreditorRow();
                                  db.deleteAllFutureGoalsRow();
                                  db.deleteAllOperationRow();
                                  Get.back();
                                  Get.forceAppUpdate();
                                  Get.back();
                                }
                              },
                              // didOpened: () async {
                              //   print("didOpened");
                              //   await localAuth(Get.overlayContext!);
                              // },
                            );
                          } else
                            {
                              db.deleteAllCategoriesRow();
                              db.deleteAllDebtorAndCreditorRow();
                              db.deleteAllFutureGoalsRow();
                              db.deleteAllOperationRow();
                              Get.back();
                              Get.forceAppUpdate();
                            }

                        },
                        confirmText: "are you sure you want to delete all data"));
                  },
                  style: ElevatedButton.styleFrom(
                      padding: AppConstant.pagePadding, onPrimary: profileTextColor, primary: profileButton),
                  child: Row(
                    children: [
                      Icon(Icons.delete_forever_outlined),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("Delete", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
