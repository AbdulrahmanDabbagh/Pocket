import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:money_managment/app/data/db/db.dart';

class ProfileController extends GetxController{
  Rx<String?> group = Rx(null);
  String? password;
  final addForm = GlobalKey<FormState>();

}