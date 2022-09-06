import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_managment/app/core/enum/type_enum.dart';
import 'package:money_managment/app/core/values/app_colors.dart';
import 'package:money_managment/app/data/db/db.dart';

import '../../../../core/values/app_constant.dart';

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({Key? key, required this.operations}) : super(key: key);
  final List<Operation> operations;

  List<Operation> get incomes => operations.where((e) => e.type == OperationType.Income.name).toList();
  List<MapEntry<DateTime, int>> combinedOperations(List<Operation> operations) => _combine(operations, dateType).entries.toList();
  List<Operation> get outcomes => operations.where((e) => e.type == OperationType.Outcome.name).toList();
  List<Operation> get creditors => operations.where((e) => e.type == OperationType.Creditor.name).toList();
  List<Operation> get debtors => operations.where((e) => e.type == OperationType.Debtor.name).toList();
  Duration get dateDifference => operations.last.date.difference(operations.first.date);
  DateType get dateType => dateDifference.inDays > 366?DateType.yearly:dateDifference.inDays > 31?DateType.monthly:DateType.daily;
  int get biggerAmount => combinedOperations(operations).fold<int>(0, (p, e) => p < e.value?e.value:p);
  int get smallerAmount => combinedOperations(operations).fold<int>(biggerAmount, (p, e) => p > e.value?e.value:p);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstant.radius)),
      margin: EdgeInsets.zero,
      elevation: 3,
      child: Column(
        children: [
          const SizedBox(height: 10,),
          if(dateType == DateType.monthly)
              Text(_combine(operations, DateType.yearly).entries.map((e) => DateFormat("yyyy").format(e.key)).join(" - ")),
          if(dateType == DateType.daily)
            Text(_combine(operations, DateType.monthly).entries.map((e) => DateFormat("yyyy/MM").format(e.key)).join(" - ")),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
            child: SizedBox(
              height: 300,
              child: LineChart(sampleData1,
                swapAnimationDuration: const Duration(milliseconds: 250),
              ),
            ),
          ),
        ],
      ),
    );
  }

  LineChartData get sampleData1 => LineChartData(
    lineTouchData: lineTouchData1,
    gridData: gridData,
    titlesData: titlesData1,
    borderData: borderData,
    lineBarsData: lineBarsData1,
    minX: 0,
    maxX: combinedOperations(operations).length.toDouble(),
    maxY: biggerAmount.toDouble(),
    minY: 0,
  );


  LineTouchData get lineTouchData1 => LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
      // getTooltipItems: (List<LineBarSpot> touchedSpots){
      //   return <LineTooltipItem?>[
      //     for(final spot in touchedSpots)
      //       LineTooltipItem(spot.y.toInt().toString(),TextStyle())
      //   ];
      // }
    ),
  );

  FlTitlesData get titlesData1 => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: bottomTitles,
    ),
    rightTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    leftTitles: AxisTitles(
      sideTitles: leftTitles(),
    ),
  );

  List<LineChartBarData> get lineBarsData1 => [
    incomeChart,
    lineChartBarData1_2,
    lineChartBarData1_3,
    lineChartBarData1_4,
  ];


  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff75729e),
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    // if(value > 10) return const SizedBox.shrink();

    // if(value == 0) {
    //   return Text('0', style: style, textAlign: TextAlign.center,maxLines: 1);
    // }
    // return Text((biggerAmount ~/ (min(10, combinedOperations(operations).length.toDouble()) - value+1)).toString(), style: style, textAlign: TextAlign.center,maxLines: 1);
    return Text(value.toInt().toString(), style: style, textAlign: TextAlign.center,maxLines: 2);
  }

  SideTitles leftTitles() => SideTitles(
    getTitlesWidget: leftTitleWidgets,
    showTitles: false,
    interval: biggerAmount/8,
    reservedSize: 40,
  );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff72719b),
      fontWeight: FontWeight.bold,
      fontSize: 11,
    );
    if(value == combinedOperations(operations).length){
      return const SizedBox.shrink();
    }
    Widget text;
    switch(dateType){
      case DateType.daily:
        text = Text(DateFormat("dd/MM").format(combinedOperations(operations)[value.toInt()].key),style: style,textAlign: TextAlign.center);
        break;
      case DateType.monthly:
        text = Text(DateFormat("MM/yy").format(combinedOperations(operations)[value.toInt()].key),style: style,textAlign: TextAlign.center);
        break;
      case DateType.yearly:
        text = Text(DateFormat("yyyy").format(combinedOperations(operations)[value.toInt()].key),style: style,textAlign: TextAlign.center);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
    showTitles: true,
    reservedSize: 32,
    interval: 1,
    getTitlesWidget: bottomTitleWidgets,
  );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
    show: true,
    border: const Border(
      bottom: BorderSide(color: Color(0xff4e4965), width: 4),
      left: BorderSide(color: Colors.transparent),
      right: BorderSide(color: Colors.transparent),
      top: BorderSide(color: Colors.transparent),
    ),
  );

  LineChartBarData get incomeChart => LineChartBarData(
    isCurved: true,
    color: Color.fromRGBO(196, 66, 101, 1.0),
    barWidth: 6,
    isStrokeCapRound: false,
    dotData: FlDotData(show: true,),
    belowBarData: BarAreaData(show: false),
    spots: [
      for(var i =0; i< combinedOperations(incomes).length; i++)
        FlSpot(spotDate(combinedOperations(incomes)[i].key), spotAmount(combinedOperations(incomes)[i].value)),
      // FlSpot(1, 1),
      // FlSpot(0.5, 2),
    ],
  );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
    isCurved: true,
    color: Color.fromRGBO(254, 190, 0, 1.0),
    barWidth: 6,
    isStrokeCapRound: true,
    dotData: FlDotData(show: true),
    belowBarData: BarAreaData(
      show: false,
      color: const Color(0x00aa4cfc),
    ),

    spots: [
      for(var i =0; i< combinedOperations(outcomes).length; i++)
        FlSpot(spotDate(combinedOperations(outcomes)[i].key), spotAmount(combinedOperations(outcomes)[i].value)),
    ],
  );

  LineChartBarData get lineChartBarData1_3 {
    // print(combinedOperations(creditors));
    return LineChartBarData(
    isCurved: true,
    color: Color.fromRGBO(0, 43, 91, 1),
    barWidth: 6,
    isStrokeCapRound: true,
    dotData: FlDotData(show: true),
    belowBarData: BarAreaData(show: false),
    spots: [
      for(var i =0; i< combinedOperations(creditors).length; i++)
        FlSpot(spotDate(combinedOperations(creditors)[i].key), spotAmount(combinedOperations(creditors)[i].value)),
    ],
  );
  }

  LineChartBarData get lineChartBarData1_4 {
    // print(combinedOperations(debtors));
    return LineChartBarData(
    isCurved: true,
    color: AppColors.number4,
    barWidth: 6,
    isStrokeCapRound: true,
    dotData: FlDotData(show: true),
    belowBarData: BarAreaData(show: false),
    spots: [
      for(var i =0; i< combinedOperations(debtors).length; i++)
        FlSpot(spotDate(combinedOperations(debtors)[i].key), spotAmount(combinedOperations(debtors)[i].value)),
    ],
  );
  }


  Map<DateTime, int> _combine(List<Operation> operations, DateType type){
    final map = <DateTime, int>{};
    for(final op in operations){
      map[getJustDate(op.date, type)] = op.amount + (map[getJustDate(op.date, type)] ?? 0);
    }
    return map;
  }

  DateTime getJustDate(DateTime date, DateType type){
    switch(type){
      case DateType.daily:
        return DateTime(date.year,date.month,date.day);
      case DateType.monthly:
        return DateTime(date.year,date.month);
      case DateType.yearly:
        return DateTime(date.year);
    }
  }

  double spotAmount(int amount){
    return amount.toDouble();
    final perc = amount / biggerAmount ;
    final y = perc * combinedOperations(operations).length;
    print(y);
    return y;
  }

  double spotDate(DateTime date){
    final index = combinedOperations(operations).indexWhere((element) => element.key == DateTime(date.year,date.month,date.day));
    return index.toDouble();
  }
}

enum DateType{
  daily,
  monthly,
  yearly,
}