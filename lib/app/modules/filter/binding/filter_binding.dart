import 'package:get/get.dart';
import 'package:money_managment/app/modules/home/controller/home_controller.dart';

import '../controller/filter_controller.dart';

class FilterBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => FilterController());
  }

}