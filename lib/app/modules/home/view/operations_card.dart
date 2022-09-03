import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_managment/app/components/confirm_operation_dialog.dart';
import 'package:money_managment/app/core/enum/type_enum.dart';
import 'package:money_managment/app/core/values/app_constant.dart';
import 'package:money_managment/app/core/values/app_strings.dart';
import 'package:money_managment/app/core/values/translation/app_translation.dart';
import 'package:money_managment/app/modules/home/controller/home_controller.dart';
import 'package:money_managment/app/modules/home/view/details_bottom_sheet.dart';
import 'package:money_managment/app/modules/home/view/earning_payoff.dart';
import 'package:money_managment/app/modules/home/view/home_page.dart';
import 'package:money_managment/app/router/app_routes.dart';
import '../../../../main.dart';
import '../../../data/db/db.dart';

class OperationsCard extends GetView<HomeController> {
  const OperationsCard({Key? key, required this.operation}) : super(key: key);
  final Operation operation;

  @override
  Widget build(BuildContext context) {
    int remain = 0;
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
            if ([OperationType.Outcome.name, OperationType.Income.name].contains(operation.type))
              PopupMenuItem(
                value: 1,
                child: Text(AppString.Details.tr),
                onTap: () async {
                  await Future.delayed(Duration(milliseconds: 50));
                  Get.showSnackbar(GetSnackBar(
                    message: operation.description,
                    icon: IconButton(
                      icon: Icon(Icons.clear_rounded),
                      color: Colors.white,
                      onPressed: () => Get.back(),
                    ),
                  ));
                },
              ),
            if ([OperationType.Debtor.name, OperationType.Creditor.name].contains(operation.type))
              PopupMenuItem(
                value: 1,
                child: Text(AppString.Details.tr),
                onTap: () async {
                  await Future.delayed(Duration(milliseconds: 50));
                  Get.bottomSheet(DetailsBottomSheet(operation, remain));
                },
              ),
            if ([OperationType.Outcome.name, OperationType.Income.name].contains(operation.type))
              PopupMenuItem(
                value: 2,
                child: Text(AppString.Edit.tr),
                onTap: () async {
                  await Future.delayed(const Duration(milliseconds: 50));
                  Get.toNamed(AppRoutes.add, arguments: operation);
                },
              ),
            PopupMenuItem (
              value: 3,
              child: Text(AppString.Delete.tr),
              onTap: () async {
                await Future.delayed(const Duration(milliseconds: 50));
                Get.dialog(ConfirmOperationDialog(
                  confirmText: AppString.Delete.tr,
                  onConfirm: () {
                    db.removeOperation(operation);
                    Get.back();
                  },
                ));
                //
              },
            ),
            if ([OperationType.Creditor.name, OperationType.Debtor.name].contains(operation.type))
              PopupMenuItem(
                value: 4,
                child: Text(controller.currentPage == OperationType.Creditor.name ? AppString.Earning.tr : AppString.Payoff.tr),
                onTap: () async {
                  await Future.delayed(Duration(milliseconds: 50));
                  Get.bottomSheet(EarningPayoff(operation, remain),isScrollControlled: true);
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
                    operation.amount.toString(),
                    style: TextStyle(fontSize: 24),
                  ),
                  const Spacer(),
                  if ([OperationType.Creditor.name, OperationType.Debtor.name].contains(operation.type))
                    StreamBuilder<List<DebtorAndCreditor>>(
                      stream: db.watchDebtorAndCreditor(operation.id!),
                      builder: (context, snapshot) {
                        final debtorCreditor = snapshot.data ?? [];
                        final count = debtorCreditor.fold<int>(0, (p, v) => p + v.amount);
                        remain = operation.amount - count;
                        final remainString = AppString.remain.tr;
                        return Text("$remainString : $remain");
                      },
                    ),
                ],
              ),
              const SizedBox(
                height: AppConstant.paddingValue,
              ),
              Row(
                children: [
                  Text(DateFormat("yyyy/MM/dd").format(operation.date)),
                  const Spacer(),
                  FutureBuilder<Category>(
                    future: db.getCategory(operation.catId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox();
                      }
                      final category = snapshot.data;
                      return Text(
                        category!.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
