import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:money_managment/app/data/db/db.dart';

class FutureGoalController extends GetxController{

  final futureGoal = Get.arguments as FutureGoal?;
  late String amount = (futureGoal?.amount ?? "").toString();
  late String description = futureGoal?.description ?? "";

  final addForm = GlobalKey<FormState>();

}