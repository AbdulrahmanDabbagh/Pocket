import 'package:get/get.dart';
import 'package:money_managment/app/modules/home/controller/home_controller.dart';

import '../../dash_board/controller/dash_board_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(()=>DashBoardController());
  }

}