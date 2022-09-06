import 'package:get/get.dart';
import 'package:money_managment/app/modules/dash_board/controller/dash_board_controller.dart';
import 'package:money_managment/app/modules/future_goal/controller/future_goal_controller.dart';

class FutureGoalBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => FutureGoalController());
  }

}