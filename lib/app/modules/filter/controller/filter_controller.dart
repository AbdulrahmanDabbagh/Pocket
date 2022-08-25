import 'package:get/get.dart';

class FilterController extends GetxController{
  Rx<DateTime> selectedStartDate = Rx(DateTime.now());
  Rx<DateTime> selectedEndDate = Rx(DateTime.now());
}

