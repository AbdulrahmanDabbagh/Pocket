import 'package:get/get.dart';
import 'package:money_managment/app/modules/home/controller/home_controller.dart';
import 'package:money_managment/app/modules/login/controller/login_controller.dart';
import 'package:money_managment/app/modules/search/controller/search_controller.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }

}