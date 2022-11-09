import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_managment/app/core/values/app_strings.dart';
import 'package:money_managment/app/core/values/app_themes.dart';
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstant.radius)),
      backgroundColor: filterBackgroundColor,
      child: Padding(
        padding: AppConstant.pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(confirmText,style: TextStyle(color: textColor)),
            const SizedBox(height: AppConstant.paddingValue),
            Text(AppString.areYouSure.tr,style: TextStyle(color: textColor)),
            const SizedBox(height: AppConstant.paddingValue),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: textFieldFillColor, shadowColor: Colors.transparent, onPrimary: AppColors.blue, elevation: 0),
                    child: Text(AppString.Cancel.tr,style: TextStyle(color: textFieldHintStyle)),
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