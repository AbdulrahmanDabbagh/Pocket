import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_managment/app/core/enum/type_enum.dart';
import 'package:money_managment/app/data/db/db.dart';
import 'package:money_managment/app/modules/home/controller/home_controller.dart';

import '../../../../main.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_constant.dart';
import '../../../core/values/app_strings.dart';
import '../../../core/values/app_themes.dart';

class EarningPayoff extends GetView<HomeController> {
  const EarningPayoff(this.operation, this.remain, {Key? key}) : super(key: key);

  final Operation operation;
  final int remain;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.addForm,
      child: BottomSheet(
        backgroundColor: earningPayoffBackgroundColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(AppConstant.radius))
        ),
        builder: (context) {
          return Padding(
            padding: AppConstant.pagePadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppConstant.radius), borderSide: BorderSide(color: textFieldBoarderColor)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppConstant.radius), borderSide: BorderSide(color: textFieldBoarderColor)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppConstant.radius), borderSide: BorderSide(color: textFieldBoarderColor)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppConstant.radius), borderSide: BorderSide(color: Colors.red)),
                    hintText: AppString.amount.tr,
                    hintStyle: TextStyle(color: textFieldHintStyle),
                    fillColor: textFieldFillColor,
                  ),
                  style: TextStyle(color: textFieldHintStyle),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  onChanged: (v) => controller.amount = int.parse(v),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return AppString.required.tr;
                    }
                    if (int.parse(value) > remain) {
                      return AppString.invalidAmount.tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppConstant.paddingValue),
                Obx(() {
                  return Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.resolveWith(
                                    (states) => textFieldFillColor),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppConstant.radius),
                                    side: BorderSide(
                                        color: textFieldFillColor))),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(11.0),
                            child: Text(
                              DateFormat('yyyy-MM-dd')
                                  .format(controller.debtorDate.value),
                              style: TextStyle(color: textFieldHintStyle, fontSize: 16),
                            ),
                          ),
                          onPressed: () async {
                            final date = await showDatePicker(
                                context: context,
                                initialDate: controller.debtorDate.value,
                                firstDate: operation.date,
                                lastDate: DateTime.now());
                            if (date != null) {
                              controller.debtorDate(date);
                            }
                          },
                        ),
                      )
                    ],
                  );
                }),
                const SizedBox(height: AppConstant.paddingValue),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppConstant.radius),
                                    side: const BorderSide(
                                        color: AppColors.number3))),
                            backgroundColor:
                            MaterialStateProperty.resolveWith(
                                    (states) => AppColors.number3)),
                        child: Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: Text(AppString.add.tr,
                              style: const TextStyle(color: AppColors.white, fontSize: 16)),
                        ),
                        onPressed: () {
                          if (controller.addForm.currentState!.validate()) {
                            db.addDebtorAndCreditor(DebtorAndCreditor(
                                operationId: operation.id!,
                                amount: controller.amount,
                                date: controller.debtorDate.value
                            ));
                            // if (operation.type == OperationType.Creditor) {
                            //   db.addOperations(Operation(
                            //       type: OperationType.Income.name,
                            //       amount: controller.amount,
                            //       date: controller.debtorDate.value,
                            //       description: AppString.,
                            //       catId: db.searchCategories(operation.type, OperationType.Creditor.name)!=null?db.getCategories(OperationType.Creditor.name) ,
                            //   ));
                            // }
                            // else {
                            //   db.addOperations(Operation(
                            //       type: OperationType.Outcome.name,
                            //       amount: controller.amount,
                            //       date: controller.debtorDate.value,
                            //       description: operation.catId.toString(),
                            //       catId: ,
                            //   ));
                            // }
                            Get.back();
                          }
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
        onClosing: () {},
      ),
    );
  }
}
