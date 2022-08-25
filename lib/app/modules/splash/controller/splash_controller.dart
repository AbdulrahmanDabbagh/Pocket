import 'package:get/get.dart';
import 'package:money_managment/app/router/app_routes.dart';

class SplashController extends GetxController{

  @override
  onInit() async{
    super.onInit();
    await Future.delayed(const Duration(seconds: 2));
    Get.offNamed(AppRoutes.home);
  }
}