import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_managment/app/components/confirm_operation_dialog.dart';
import 'package:money_managment/app/core/enum/type_enum.dart';
import 'package:money_managment/app/core/values/app_constant.dart';
import 'package:money_managment/app/core/values/app_strings.dart';
import 'package:money_managment/app/core/values/translation/app_translation.dart';
import 'package:money_managment/app/modules/add_future_goal/view/add_future_goal_view.dart';
import 'package:money_managment/app/modules/home/controller/home_controller.dart';
import 'package:money_managment/app/router/app_routes.dart';
import '../../../../main.dart';
import '../../../data/db/db.dart';

class FutureGoalCard extends GetView<HomeController> {
  const FutureGoalCard({Key? key, required this.futureGoal}) : super(key: key);
  final FutureGoal futureGoal;

  @override
  Widget build(BuildContext context) {
    return GestureDetector (
      onTapDown: (detials) {
        double start = detials.globalPosition.dx;
        if(AppTranslation.isArabic){
          start = MediaQuery.of(context).size.width - start;
        }
        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(
              start, detials.globalPosition.dy, start, detials.localPosition.dy),
          items: [
              PopupMenuItem(
                value: 1,
                child: Text(AppString.Edit.tr),
                onTap: () async {
                  await Future.delayed(const Duration(milliseconds: 50));
                  Get.toNamed(AppRoutes.addFutureGoal,arguments: futureGoal);
                },
              ),
            PopupMenuItem (
              value: 2,
              child: Text(AppString.Delete.tr),
              onTap: () async {
                await Future.delayed(const Duration(milliseconds: 50));
                Get.dialog(ConfirmOperationDialog(
                  confirmText: AppString.Delete.tr,
                  onConfirm: () {
                    db.removeFutureGoal(futureGoal);
                    Get.back();
                  },
                ));
                //
              },
            ),
            PopupMenuItem (
              value: 3,
              child: Text(AppString.doIt.tr),
              onTap: () async {
                await Future.delayed(const Duration(milliseconds: 50));
                Get.dialog(ConfirmOperationDialog(
                  confirmText: AppString.doIt.tr,
                  onConfirm: () {
                    // stream
                    // dialog

                    // Get.toNamed(AppRoutes.addOperation, arguments: Operation(type: OperationType.Outcome.name,
                    //     amount: futureGoal.amount,
                    //     date: DateTime.now(),
                    //     description: futureGoal.description,
                    //     catId: )); //todo args
                    db.removeFutureGoal(futureGoal);
                    Get.back();
                  },
                ));
                //
              },
            ),
          ],
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    futureGoal.amount.toString(),
                    style: const TextStyle(fontSize: 24),
                  ),
                ],
              ),
              const SizedBox(
                height: AppConstant.paddingValue,
              ),
              Row(
                children: [
                  Text(futureGoal.description, style: const TextStyle(fontWeight: FontWeight.bold),)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
