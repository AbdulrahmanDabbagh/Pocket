import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_managment/app/components/filter/view/filter_view.dart';
import 'package:money_managment/main.dart';
import '../../../data/db/db.dart';
import '../../../data/models/filter.dart';

class SearchController extends GetxController{

  Rx<String> searchText = Rx("");
  TextEditingController textSearchController = TextEditingController();
  final operations = <Operation>[].obs;
  Filter filter = Filter();

  search() async {
    operations.assignAll(await db.filterOperations(filter..search = searchText.value));
  }

  filterButton() async {
    final filter = await Get.dialog(const FilterView());
    if(filter is Filter){
      this.filter = filter;
      search();
    }
  }

  @override
  onInit() async {
    super.onInit();
    search();
  }

}