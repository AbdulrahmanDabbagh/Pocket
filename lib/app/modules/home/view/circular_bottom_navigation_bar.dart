import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:get/get.dart';
import 'package:money_managment/app/core/values/app_colors.dart';
import 'package:money_managment/app/core/values/app_strings.dart';
import 'package:money_managment/app/core/values/app_themes.dart';
import 'package:money_managment/app/modules/home/controller/home_controller.dart';

import '../../../core/enum/type_enum.dart';

class CircularBottomNavigationBar extends GetView<HomeController> {
  CircularBottomNavigationBar({Key? key}) : super(key: key);


  late final CircularBottomNavigationController _navigationController =
  CircularBottomNavigationController(controller.selectedPos.value);

  final List<TabItem> tabItems = List.of([
    TabItem(Icons.settings, AppString.profile , Colors.red),
    TabItem(Icons.home, AppString.Dashboard , AppColors.number2),
    TabItem(Icons.golf_course_outlined, AppString.futureGoals , AppColors.number2),
  ]);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CircularBottomNavigation(
        tabItems,
        controller: _navigationController,
        selectedPos: controller.selectedPos.value,
        barBackgroundColor: bottomNavigationBarBackgroundColor,
        backgroundBoxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black45, blurRadius: 0),
        ],
        animationDuration: Duration(milliseconds: 300),
        selectedCallback: (int? selectedPos) {
          controller.selectedPos.value = selectedPos ?? 1;
          // if(controller.selectedPos.value == 0) controller.currentPage.value= OperationType.Outcome.name;
          // if(controller.selectedPos.value == 1) controller.currentPage.value=OperationType.Income.name ;
          // if(controller.selectedPos.value == 2) controller.currentPage.value=OperationType.Creditor.name  ;
        },
        selectedIconColor: AppColors.number4,
        normalIconColor: AppColors.number3,
      );
    });
  }
}
