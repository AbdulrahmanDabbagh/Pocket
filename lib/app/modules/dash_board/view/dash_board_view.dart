import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_managment/app/core/enum/type_enum.dart';
import 'package:money_managment/app/core/values/app_constant.dart';
import 'package:money_managment/app/modules/dash_board/controller/dash_board_controller.dart';
import 'package:money_managment/app/modules/dash_board/view/widgets/bar_chart_widget.dart';
import 'package:money_managment/app/modules/dash_board/view/widgets/line_chart_widget.dart';
import 'package:money_managment/app/modules/dash_board/view/widgets/operation_view.dart';
import 'package:money_managment/app/modules/dash_board/view/widgets/rect_card.dart';
import 'package:money_managment/app/modules/dash_board/view/widgets/sqaure_info_card.dart';
import 'package:money_managment/main.dart';

import '../../../core/values/app_strings.dart';

class DashBoardView extends GetView<DashBoardController> {
  const DashBoardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.Dashboard.tr),
        actions: [
          IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                controller.filterButton();
              })
        ],
      ),
      body: Obx(() {
        return ListView(
          padding: AppConstant.pagePadding,
          children: [
            RectCard(
                subtitle1: "${AppString.TotalCash.tr} ",
                subtitle2: "${AppString.Budget.tr} ",
                amount1: controller.totalCash,
                amount2: controller.totalBudge),
            const SizedBox(height: AppConstant.paddingValue),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                      onTap: () {
                        Get.to(const OperationView(OperationType.Income));
                      },
                      child: SquareInfoCard(title: AppString.TotalIncome.tr, amount: controller.total(OperationType.Income))),
                ),
                const SizedBox(width: AppConstant.paddingValue),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(const OperationView(OperationType.Outcome));
                    },
                    child: SquareInfoCard(title: AppString.TotalOutcome.tr, amount: controller.total(OperationType.Outcome)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstant.paddingValue),
            GestureDetector(
              onTap: () {
                Get.to(const OperationView(OperationType.Debtor));
              },
              child: FutureBuilder<int?>(
                  future: db.getTotalPaidDebtor(),
                  builder: (context, snapshot) {
                    return RectCard(
                      title: "${AppString.total.tr} ${OperationType.Debtor.name.tr}",
                      subtitle1: AppString.paid.tr,
                      amount1: (snapshot.data ?? 0),
                      subtitle2: AppString.unpaid.tr,
                      amount2: controller.total(OperationType.Debtor) - (snapshot.data ?? 0),
                    );
                  }),
            ),
            const SizedBox(height: AppConstant.paddingValue),
            GestureDetector(
              onTap: () {
                Get.to(const OperationView(OperationType.Creditor));
              },
              child: FutureBuilder<int?>(
                  future: db.getTotalEarnCreditor(),
                  builder: (context, snapshot) {
                    return RectCard(
                      title: "${AppString.total.tr} ${OperationType.Creditor.name.tr}",
                      subtitle1: AppString.paid.tr,
                      amount1: (snapshot.data ?? 0),
                      subtitle2: AppString.unpaid.tr,
                      amount2: controller.total(OperationType.Creditor) - (snapshot.data ?? 0),
                    );
                  }),
            ),
            const SizedBox(height: AppConstant.paddingValue),
            if (controller.incomes.isNotEmpty)
              BarChartWidget(operations: controller.outcomes, title: OperationType.Outcome.name.tr),
            const SizedBox(height: AppConstant.paddingValue),
            if (controller.incomes.isNotEmpty)
              BarChartWidget(operations: controller.incomes, title: OperationType.Income.name.tr),
            const SizedBox(height: AppConstant.paddingValue),
            if (controller.operations.isNotEmpty) LineChartWidget(operations: controller.operations),
          ],
        );
      }),
    );
  }
}
