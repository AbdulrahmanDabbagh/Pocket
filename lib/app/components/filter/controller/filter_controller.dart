import 'package:get/get.dart';
import 'package:money_managment/app/core/enum/type_enum.dart';
import 'package:money_managment/app/data/db/db.dart';
import 'package:money_managment/main.dart';

class FilterController extends GetxController{
  Rx<DateTime> fromDate = Rx(DateTime.now());
  Rx<DateTime> endDate = Rx(DateTime.now());
  final selectedTypes = <OperationType>[].obs;
  final selectedCategories = <Category>[].obs;

  final allOperations = <Operation>[];

  @override
  onInit() async {
    super.onInit();
    allOperations.assignAll(await db.getAllOperations());
    fromDate(allOperations.first.date);
    endDate(allOperations.last.date);
  }

}

