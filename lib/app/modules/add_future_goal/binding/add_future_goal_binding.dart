import 'package:get/get.dart';
import 'package:money_managment/app/modules/add_future_goal/controller/add_future_goal_controller.dart';

class AddFutureGoalbinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AddFutureGoalController());
  }

}