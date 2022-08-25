import 'package:get/get.dart';
import 'package:money_managment/app/modules/dash_board/controller/dash_board_controller.dart';
import 'package:money_managment/app/modules/home/controller/home_controller.dart';
import 'package:money_managment/app/modules/search/controller/search_controller.dart';

class DashBoardBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => DashBoardController());
  }

}