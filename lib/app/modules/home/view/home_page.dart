
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_managment/app/core/values/app_colors.dart';
import 'package:money_managment/app/core/values/app_constant.dart';
import 'package:money_managment/app/core/values/app_strings.dart';
import 'package:money_managment/app/modules/dash_board/view/dash_board_view.dart';
import 'package:money_managment/app/modules/future_goal/view/future_goal_view.dart';
import 'package:money_managment/app/modules/home/view/bottom_navigation_bar.dart';
import 'package:money_managment/app/modules/home/view/circular_bottom_navigation_bar.dart';
import 'package:money_managment/app/modules/profile/view/profile_view.dart';
import 'package:money_managment/app/router/app_routes.dart';
import '../../../../main.dart';
import '../../../core/values/translation/app_translation.dart';
import '../../../data/db/db.dart';
import '../controller/home_controller.dart';
import 'operations_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text("Money Manager"),
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.blue,

            actions: [
              IconButton(
                  onPressed: (){controller.searchButton();},
                  icon: Icon(Icons.search)
              ),
            ] ,
          ),
          body: [ProfileView(), DashBoardView(), FutureGoalView()][controller.selectedPos.value],

          // Obx((){
          //     return StreamBuilder<List<Operation>>(
          //       stream: db.watchOperations(controller.currentPage.value),
          //       builder: (context, snapshot) {
          //         final operations = snapshot.data ?? [];
          //         return ListView.builder(
          //           padding: AppConstant.pagePadding,
          //           itemCount: operations.length,
          //             itemBuilder: (context, index){
          //               return OperationsCard(operation: operations[index]);
          //             },
          //         );
          //       }
          //     );
          //   }
          // ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: (){
          //     // Get.toNamed("page", arguments: operation); /// from home
          //     // final operation = Get.arguments as Operation?; /// from add_operation controller
          //     Get.toNamed(AppRoutes.add_operation);
          //   },
          //   child:
          //   Icon(Icons.add_operation , color: AppColors.number4),
          //   backgroundColor: AppColors.number2,
          // ),
          bottomNavigationBar: CircularBottomNavigation(
            [
              TabItem(Icons.settings, AppString.profile , AppColors.number2),
              TabItem(Icons.home, AppString.Dashboard , AppColors.number2),
              TabItem(Icons.golf_course_outlined, AppString.futureGoals , AppColors.number2),
            ],
            controller: controller.navigationController,
            selectedPos: controller.selectedPos.value,
            barBackgroundColor: Colors.white,
            backgroundBoxShadow: const <BoxShadow>[
              BoxShadow(color: Colors.black45, blurRadius: 0),
            ],
            animationDuration: Duration(milliseconds: 300),
            selectedCallback: (int? selectedPos) {
              controller.selectedPos.value = selectedPos ?? 0;
              // if(controller.selectedPos.value == 0) controller.currentPage.value= OperationType.Outcome.name;
              // if(controller.selectedPos.value == 1) controller.currentPage.value=OperationType.Income.name ;
              // if(controller.selectedPos.value == 2) controller.currentPage.value=OperationType.Creditor.name  ;
            },
            selectedIconColor: AppColors.white,
            normalIconColor: AppColors.number3,
            circleSize: 40,
            iconsSize: 20,
            barHeight: 45,
          ),
        );
      }
    );

  }
}
