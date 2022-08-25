import 'package:get/get.dart';
import 'package:money_managment/app/router/app_routes.dart';

import '../../../core/enum/type_enum.dart';
import '../../../data/db/db.dart';

class HomeController extends GetxController{
  Rx<Categorie?> selectedCategory = Rx(null);
  Rx<DateTime> selectedDate = Rx(DateTime.now());
  var currentIndexBNB = 0.obs ;
  Rx<String> currentPage = Rx(OperationType.Outcome.name);

  searchButton(){
    Get.toNamed(AppRoutes.search);
  }

  dashBoardButton(){
    Get.toNamed(AppRoutes.dash_board);
  }
}