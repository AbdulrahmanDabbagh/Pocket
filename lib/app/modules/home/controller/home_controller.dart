import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:money_managment/app/router/app_routes.dart';

import '../../../core/enum/type_enum.dart';
import '../../../data/db/db.dart';

class HomeController extends GetxController{
  Rx<Category?> selectedCategory = Rx(null);
  Rx<DateTime> selectedDate = Rx(DateTime.now());
  Rx<String> currentPage = Rx(OperationType.Outcome.name);
  Rx<DateTime> debtorDate = Rx(DateTime.now());
  Rx<List<Category>?> filterCategory = Rx(null);
  var currentIndexBNB = 0.obs ;
  late int amount;
  final addForm = GlobalKey<FormState>();
  bool? delete;
  var selectedPos = 0.obs ;

  searchButton(){
    Get.toNamed(AppRoutes.search);
  }

  dashBoardButton(){
    Get.toNamed(AppRoutes.dash_board);
  }
}