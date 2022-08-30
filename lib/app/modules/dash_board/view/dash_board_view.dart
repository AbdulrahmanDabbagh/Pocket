import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:money_managment/app/core/enum/type_enum.dart';
import 'package:money_managment/app/core/extensions/num_extension.dart';
import 'package:money_managment/app/core/values/app_colors.dart';
import 'package:money_managment/app/core/values/app_constant.dart';
import 'package:money_managment/app/modules/dash_board/controller/dash_board_controller.dart';
import 'package:money_managment/main.dart';

import '../../../core/values/app_strings.dart';

class DashBoardView extends GetView<DashBoardController> {
  const DashBoardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    db.getTotalPaidDebtor();
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
              Row(
                children: [
                  Expanded(
                      child: _InfoCard(
                          title: AppString.TotalIncome.tr,
                          amount: controller.total(OperationType.Income))),
                  const SizedBox(width: AppConstant.paddingValue),
                  Expanded(
                      child: _InfoCard(
                          title: AppString.TotalOutcome.tr,
                          amount: controller.total(OperationType.Outcome))),
                ],
              ),
              const SizedBox(height: AppConstant.paddingValue),
              Row(
                children: [
                  Expanded(
                      child: FutureBuilder<int?>(
                        future: db.getTotalPaidDebtor(),
                        builder: (context, snapshot) {
                          return _InfoCard(
                              title: "Total ${OperationType.Debtor.name.tr}",
                              amount: controller.total(OperationType.Debtor) - (snapshot.data??0));
                        }
                      )),
                  const SizedBox(width: AppConstant.paddingValue),
                  Expanded(
                      child: FutureBuilder<int?>(
                        future: db.getTotalEarnCreditor(),
                        builder: (context, snapshot) {
                          return _InfoCard(
                              title: "Total ${OperationType.Creditor.name.tr}",
                              amount: controller.total(OperationType.Creditor) - (snapshot.data??0));
                        }
                      )),
                ],
              ),
              const SizedBox(height: AppConstant.paddingValue),
              Card(
                shape: RoundedRectangleBorder(
                    // side: BorderSide(color: AppColors.number3),
                    borderRadius: BorderRadius.circular(AppConstant.radius)),
                margin: EdgeInsets.zero,
                // color: AppColors.number2,
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            "${AppString.TotalCash.tr}: ",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${controller.totalCash.withComma} s.p",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "${AppString.Budget.tr}: ",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text("${controller.totalBudge.withComma} s.p",
                              style: TextStyle(fontSize: 20))
                        ],
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
                        PieChartData(
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 0,
                            sections: [
                              PieChartSectionData(
                                color: const Color(0xff0293ee),
                                value: 30,
                                title: '30%',
                                radius: 75,
                              ),
                              PieChartSectionData(
                                color: const Color(0xff02ee80),
                                value: 30,
                                title: '30%',
                                radius: 75,
                              ),
                              PieChartSectionData(
                                color: const Color(0xffee0274),
                                value: 40,
                                title: '40%',
                                radius: 75,
                              ),
                            ]),
                      ),
                    ),
                  ),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Obx(() {
                        return PieChart(
                          PieChartData(
                              pieTouchData: PieTouchData(touchCallback:
                                  (FlTouchEvent event, pieTouchResponse) {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  controller.touchedIndex(-1);
                                  return;
                                }
                                controller.touchedIndex.value = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              }),
                              borderData: FlBorderData(
                                show: false,
                              ),
                              sectionsSpace: 0,
                              centerSpaceRadius: 0,
                              sections: List.generate(3, (index) {
                                final isTouched =
                                    index == controller.touchedIndex.value;
                                final fontSize = isTouched ? 25.0 : 16.0;
                                final radius = isTouched ? 80.0 : 70.0;
                                switch (index) {
                                  case 0:
                                    return PieChartSectionData(
                                      color: const Color(0xff0293ee),
                                      value: 30,
                                      title: '30%',
                                      radius: radius,
                                    );
                                  case 1:
                                    return PieChartSectionData(
                                      color: const Color(0xff02ee80),
                                      value: 30,
                                      title: '30%',
                                      radius: radius,
                                    );
                                  default:
                                    return PieChartSectionData(
                                      color: const Color(0xffee0274),
                                      value: 40,
                                      title: '40%',
                                      radius: radius,
                                    );
                                }
                              })),
                        );
                      }),
                    ),
                  ),
                ],
              )
            ],
          );
        }
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({Key? key, required this.title, required this.amount})
      : super(key: key);
  final String title;
  final num amount;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          // side: const BorderSide(color: AppColors.number2,width: 0.2),
          borderRadius: BorderRadius.circular(AppConstant.radius)),
      elevation: 3,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: AppConstant.pagePadding,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 21,
              child: Center(
                child: AutoSizeText(
                  "${amount.withComma}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                  maxLines: 1,
                  maxFontSize: 20,
                ),
              ),
            ),
            Text("s.p",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
