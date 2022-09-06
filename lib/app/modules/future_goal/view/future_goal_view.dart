import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:money_managment/app/data/db/db.dart';

import '../../../../main.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_constant.dart';
import '../../../router/app_routes.dart';
import 'future_goals_card.dart';

class FutureGoalView extends StatelessWidget {
  const FutureGoalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body:StreamBuilder<List<FutureGoal>>(
            stream: db.watchFutureGoals(),
            builder: (context, snapshot) {
              final futureGoal = snapshot.data ?? [];
              return ListView.builder(
                padding: AppConstant.pagePadding,
                itemCount: futureGoal.length,
                itemBuilder: (context, index){
                  return FutureGoalCard(futureGoal: futureGoal[index]);
                },
              );
            }
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // Get.toNamed("page", arguments: operation); /// from home
          // final operation = Get.arguments as Operation?; /// from add_operation controller
          Get.toNamed(AppRoutes.addFutureGoal);
        },
        backgroundColor: AppColors.number2,
        child:
        const Icon(Icons.add , color: AppColors.number4),
      ),
    );
  }
}
