import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_managment/app/core/values/app_strings.dart';
import 'package:money_managment/app/data/db/db.dart';
import '../../main.dart';
import '../core/values/app_colors.dart';
import '../core/values/app_constant.dart';

class ConfirmOperationDialog extends StatelessWidget {
  const ConfirmOperationDialog({Key? key, required this.onConfirm, required this.confirmText}) : super(key: key);
  final void Function() onConfirm;
  final String confirmText;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: AppConstant.pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(confirmText,style: const TextStyle(color: AppColors.blue)),
            const SizedBox(height: AppConstant.paddingValue),
            Text(AppString.areYouSure.tr,style: const TextStyle(color: AppColors.number2)),
            const SizedBox(height: AppConstant.paddingValue),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: AppColors.white, shadowColor: Colors.transparent, onPrimary: AppColors.blue, elevation: 0),
                    child: Text(AppString.Cancel.tr),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                      onPressed: onConfirm,
                      child: Text(confirmText)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}