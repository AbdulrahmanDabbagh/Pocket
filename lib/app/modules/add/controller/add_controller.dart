import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_managment/app/router/app_routes.dart';

import '../../../data/db/db.dart';

class AddController extends GetxController{
  Rx<Categorie?> selectedCategory = Rx(null);
  Rx<DateTime> selectedDate = Rx(DateTime.now());

  final operation = Get.arguments as Operation?;

  final addForm = GlobalKey<FormState>();
  late String amount;
  late String description;
  late String type;
}