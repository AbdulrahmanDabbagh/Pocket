import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_managment/app/core/values/app_colors.dart';
import 'package:money_managment/app/core/values/app_constant.dart';
import 'package:money_managment/app/core/values/app_strings.dart';
import 'package:money_managment/app/core/values/app_themes.dart';
import 'package:money_managment/app/modules/dash_board/controller/dash_board_controller.dart';
import 'package:money_managment/app/modules/dash_board/view/dash_board_view.dart';
import 'package:money_managment/app/modules/future_goal/view/future_goal_view.dart';
import 'package:money_managment/app/modules/home/view/bottom_navigation_bar.dart';
import 'package:money_managment/app/modules/home/view/circular_bottom_navigation_bar.dart';
import 'package:money_managment/app/modules/profile/view/profile_view.dart';
import 'package:money_managment/app/router/app_routes.dart';
import '../../../../main.dart';
import '../../../core/utils/background_image.dart';
import '../../../core/values/translation/app_translation.dart';
import '../../../data/db/db.dart';
import '../controller/home_controller.dart';
import 'operations_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(color: AppColors.number2,fontWeight: FontWeight.bold);
    return Obx(() {
      return Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: const Text("Money Manager",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23)),
          actions: [
            IconButton(
                onPressed: () {
                  controller.searchButton();
                },
                icon: Icon(Icons.search)),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: backgroundImage,
          ),
          child: [ProfileView(), DashBoardView(), FutureGoalView()][controller.selectedPos.value],
        ),

        floatingActionButton: controller.selectedPos.value == 0 ? null:FloatingActionButton(
          onPressed: () {
            if(controller.selectedPos.value == 1){
              Get.find<DashBoardController>().filterButton();
            } else if(controller.selectedPos.value == 2){
              Get.toNamed(AppRoutes.addFutureGoal);
            }
            // controller.filterButton();
          },
          backgroundColor: floatingActionButtonBackgroundColor,
          child:Icon(controller.selectedPos.value == 1?Icons.filter_list:Icons.add , color: floatingActionButtonIconColor),
        ),
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
            TabItem(Icons.settings, AppString.profile, bottomNavigationBarIconColor,labelStyle: labelStyle),
            TabItem(Icons.home, AppString.Dashboard, bottomNavigationBarIconColor,labelStyle: labelStyle),
            TabItem(Icons.golf_course_outlined, AppString.futureGoals, bottomNavigationBarIconColor ,labelStyle: labelStyle),
          ],
          controller: controller.navigationController,
          selectedPos: controller.selectedPos.value,
          barBackgroundColor: bottomNavigationBarBackgroundColor,
          backgroundBoxShadow: const <BoxShadow>[
            BoxShadow(color: Colors.black45, blurRadius: 0),
          ],
          animationDuration: Duration(milliseconds: 300),
          selectedCallback: (int? selectedPos) {
            controller.selectedPos.value = selectedPos ?? 1;
          },
          selectedIconColor: bottomNavigationBarselectedIconColor ,
          normalIconColor: bottomNavigationBarnormalIconColor,
          circleSize: 45,
          iconsSize: 25,
          barHeight: 50,
        ),
      );
    });
  }
}
