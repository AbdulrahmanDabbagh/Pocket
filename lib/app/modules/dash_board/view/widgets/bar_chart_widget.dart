import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:money_managment/app/core/extensions/num_extension.dart';
import 'package:money_managment/app/core/values/app_colors.dart';
import 'package:money_managment/app/data/db/db.dart';
import 'package:money_managment/main.dart';

import '../../../../core/values/app_constant.dart';

class BarChartWidget extends StatefulWidget {
  const BarChartWidget({Key? key, required this.operations, required this.title}) : super(key: key);
  final String title;
  final List<Operation> operations;

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartWidget> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstant.radius)),
      margin: EdgeInsets.zero,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              widget.title,
              style: const TextStyle(
                  color: Color(0xff0f4a3c),
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 38,
            ),
            SizedBox(
              height: _combine(widget.operations).length * 30,
              child: Padding(
                padding: const EdgeInsets.only(right: 50),
                child: RotatedBox(
                  quarterTurns: 1,
                  child: BarChart(
                    mainBarData(),
                    swapAnimationDuration: animDuration,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
      int x,
      double y, {
        bool isTouched = false,
        Color barColor = AppColors.blue,
        double width = 15,
        List<int> showTooltips = const [],
      }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: barColor,
          width: width,
        ),
      ],
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(_combine(widget.operations).length, (i) {
    final op = _combine(widget.operations).entries.toList()[i];
    return makeGroupData(op.key, op.value.toDouble(), isTouched: i == touchedIndex);

  });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                  _combine(widget.operations)[group.x]!.withComma,
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              );
            },
            rotateAngle: 270,
            tooltipPadding: const EdgeInsets.all(5),
          tooltipMargin: 0,
          maxContentWidth: 60
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 50,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: AppColors.blue,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      angle: 4.7,
      child: FutureBuilder<Category>(
        future: db.getCategory(value.toInt()),
        builder: (context, snapshot) {
          return Text(snapshot.data?.name ?? "", style: style);
        }
      ),
    );
  }


  Map<int, int> _combine(List<Operation> operations){
    final map = <int, int>{};
    for(final op in operations){
      map[op.catId] = op.amount + (map[op.catId] ?? 0);
    }
    return map;
  }
}