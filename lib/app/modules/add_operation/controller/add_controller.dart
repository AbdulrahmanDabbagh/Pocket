import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_managment/app/core/enum/type_enum.dart';
import 'package:money_managment/main.dart';

import '../../../data/db/db.dart';

class AddController extends GetxController {
  final operation = Get.arguments as Operation?;

  Rx<Category?> selectedCategory = Rx(null);
  late Rx<DateTime> selectedDate = Rx(operation?.date ?? DateTime.now());

  final addForm = GlobalKey<FormState>();
  late String amount = (operation?.amount ?? "").toString();
  late String? description = operation?.description;
  late Rx<String> type = Rx(operation?.type ?? OperationType.Outcome.name);

  @override
  void onInit() async {
    super.onInit();
    final categories = await db.getCategoriesType(type.value);
    if (operation != null) {
      selectedCategory.value = categories.singleWhere((element) => element.id == operation!.catId);
    }
  }
}
