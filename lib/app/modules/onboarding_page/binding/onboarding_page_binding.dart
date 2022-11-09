import 'package:get/get.dart';
import 'package:money_managment/app/modules/onboarding_page/controller/onboarding_page_controller.dart';
import 'package:money_managment/app/modules/splash/controller/splash_controller.dart';

class OnboardingPageBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => OnboardingPageController());
  }
}