import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingPageController extends GetxController{
  final pageController = PageController();

  String? amount;
  final addForm = GlobalKey<FormState>();
  Rx<String?> group = Rx(null);
  String? password;
  @override
  dispose(){
    pageController.dispose();
    super.dispose();
  }
}