import 'package:get/get.dart';

import '../values/app_strings.dart';

class AppValidator{
  static String? required(String? value){
    if(value == null || value .isEmpty){
      return AppString.required.tr;
    }
    return null;
  }
}