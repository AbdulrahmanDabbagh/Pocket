import 'package:get/get.dart';
import 'package:money_managment/app/modules/splash/controller/splash_controller.dart';

class SplashBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}