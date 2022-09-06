import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_managment/app/core/enum/type_enum.dart';
import 'package:money_managment/main.dart';

import '../../../data/db/db.dart';

class AddFutureGoalController extends GetxController {

  final futureGoal = Get.arguments as FutureGoal?;
  late String amount = (futureGoal?.amount ?? "").toString();
  late String description = futureGoal?.description ?? "";
  final addForm = GlobalKey<FormState>();

}
