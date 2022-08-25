import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:money_managment/app/core/enum/type_enum.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/app_strings.dart';
import '../controller/home_controller.dart';

class BNB extends GetView<HomeController> {
  const BNB ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx((){
        return BottomNavigationBar(
          backgroundColor: AppColors.number2,
          selectedItemColor: AppColors.number4,
          unselectedItemColor: AppColors.number3,
          items:  [
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/images/outcome.png'),size: 25,),
                label: AppString.Outcome.tr,
                backgroundColor: AppColors.number2,
            ),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/images/incomes.png')),
                label: AppString.Income.tr,
                backgroundColor: AppColors.number2
            ),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/images/creditor.png')),
                label: AppString.Creditor.tr,
                backgroundColor: AppColors.number2
            ),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/images/liability.png')),
                label: AppString.Debtor.tr,
                backgroundColor: AppColors.number2
            ),
          ],
          currentIndex: controller.currentIndexBNB.value,
          onTap: (value){
            controller.currentIndexBNB.value = value;
            if(value == 0) controller.currentPage.value= OperationType.Outcome.name;
            if(value == 1) controller.currentPage.value=OperationType.Income.name ;
            if(value == 2) controller.currentPage.value=OperationType.Creditor.name  ;
            if(value == 3) controller.currentPage.value=OperationType.Debtor.name ;
          },
        );
      }
    );
  }
}
