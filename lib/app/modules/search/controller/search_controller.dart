import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_managment/app/modules/filter/controller/filter_controller.dart';
import 'package:money_managment/app/modules/filter/view/filter_view.dart';
import 'package:money_managment/app/router/app_routes.dart';

import '../../../data/db/db.dart';
import '../../../data/models/filter.dart';

class SearchController extends GetxController{

  late Rx<String> searchText = Rx("");
  Rx<TextEditingController> textSearchController = Rx(TextEditingController());
  filterButton() async {
    final filter = await Get.dialog(FilterView());
    if(filter is Filter){

    }
  }


}