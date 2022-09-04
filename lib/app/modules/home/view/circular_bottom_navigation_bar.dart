import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:get/get.dart';
import 'package:money_managment/app/core/values/app_strings.dart';
import 'package:money_managment/app/modules/home/controller/home_controller.dart';

import '../../../core/enum/type_enum.dart';

class CircularBottomNavigationBar extends GetView<HomeController> {
  CircularBottomNavigationBar({Key? key}) : super(key: key);


  late final CircularBottomNavigationController _navigationController =
  CircularBottomNavigationController(controller.selectedPos.value);

  final List<TabItem> tabItems = List.of([
    TabItem(Icons.home, AppString.profile , Colors.blue, labelStyle: TextStyle(fontWeight: FontWeight.normal)),
    TabItem(Icons.settings, AppString.Dashboard , Colors.orange, labelStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
    TabItem(Icons.golf_course_outlined, AppString.futureGoals , Colors.red),
  ]);

  Widget build(BuildContext context) {
    return Obx(() {
      return CircularBottomNavigation(
        tabItems,
        controller: _navigationController,
        selectedPos: controller.selectedPos.value,
        barBackgroundColor: Colors.white,
        backgroundBoxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black45, blurRadius: 10.0),
        ],
        animationDuration: Duration(milliseconds: 300),
        selectedCallback: (int? selectedPos) {
          controller.selectedPos.value = selectedPos ?? 0;
          if(controller.selectedPos.value == 0) controller.currentPage.value= OperationType.Outcome.name;
          if(controller.selectedPos.value == 1) controller.currentPage.value=OperationType.Income.name ;
          if(controller.selectedPos.value == 2) controller.currentPage.value=OperationType.Creditor.name  ;
        },
      );
    });
  }
}
