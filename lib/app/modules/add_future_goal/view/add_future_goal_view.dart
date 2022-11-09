import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../../main.dart';
import '../../../core/utils/background_image.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_constant.dart';
import '../../../core/values/app_strings.dart';
import '../../../core/values/app_themes.dart';
import '../../../data/db/db.dart';
import '../controller/add_future_goal_controller.dart';

class AddFutureGoalView extends GetView<AddFutureGoalController> {
  const AddFutureGoalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.addOperation.tr, style: const TextStyle(color: AppColors.white)),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: backgroundImage,
        ),
        child: Form(
          key: controller.addForm,
          child: Padding(
            padding: AppConstant.pagePadding,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstant.radius),
                          borderSide: BorderSide(color: textFieldBoarderColor)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstant.radius),
                          borderSide: BorderSide(color: textFieldBoarderColor)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstant.radius),
                          borderSide: BorderSide(color: textFieldBoarderColor)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstant.radius), borderSide: BorderSide(color: Colors.red)),
                      hintText: AppString.amount.tr,
                      hintStyle: TextStyle(color: textFieldHintStyle),
                      fillColor: textFieldFillColor,
                      filled: true),
                  style: TextStyle(color: textFieldHintStyle),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  initialValue: (controller.futureGoal?.amount ?? "").toString(),
                  onChanged: (v) => controller.amount = v,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return AppString.required.tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppConstant.paddingValue),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstant.radius),
                          borderSide: BorderSide(color: textFieldBoarderColor)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstant.radius),
                          borderSide: BorderSide(color: textFieldBoarderColor)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstant.radius),
                          borderSide: BorderSide(color: textFieldBoarderColor)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstant.radius), borderSide: BorderSide(color: Colors.red)),
                      hintText: AppString.description.tr,
                      hintStyle: TextStyle(color: textFieldHintStyle),
                      fillColor: textFieldFillColor,
                      filled: true),
                  style: TextStyle(color: textFieldHintStyle),
                  initialValue: (controller.futureGoal?.description ?? "").toString(),
                  onChanged: (v) => controller.description = v,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return AppString.required.tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppConstant.paddingValue),
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppConstant.radius),
                          side: const BorderSide(color: AppColors.number3))),
                      backgroundColor: MaterialStateProperty.resolveWith((states) => AppColors.number3)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Text(controller.futureGoal == null ? AppString.add.tr : AppString.Edit.tr,
                          style: const TextStyle(color: AppColors.white, fontSize: 16)),
                    ),
                  ),
                  onPressed: () {
                    if (controller.addForm.currentState!.validate()) {
                      if (controller.futureGoal == null) {
                        db.addFutureGoal(FutureGoal(amount: int.parse(controller.amount), description: controller.description));
                      } else {
                        final editedFutureGoals = FutureGoal(
                            id: controller.futureGoal!.id,
                            amount: int.parse(controller.amount),
                            description: controller.description);
                        db.editFutureGoal(editedFutureGoals);
                      }
                      Get.back();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
