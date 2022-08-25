import 'package:get/get.dart';
import 'package:money_managment/app/core/enum/type_enum.dart';
import 'package:money_managment/app/data/db/db.dart';
import 'package:money_managment/app/data/models/filter.dart';
import 'package:money_managment/app/modules/filter/view/filter_view.dart';
import 'package:money_managment/main.dart';

class DashBoardController extends GetxController{

  final operations = <Operation>[].obs;

  num total(OperationType operationType){
    final incomeOperations = operations.where((e) => e.type == operationType.name).toList();
    return incomeOperations.fold<int>(0,(value, element) => value + element.amount);
  }

  num get totalCash {
   return (total(OperationType.Income) + total(OperationType.Debtor)) - (total(OperationType.Outcome) + total(OperationType.Creditor));
  }

  num get totalBudge {
   return (total(OperationType.Income) + total(OperationType.Creditor)) - (total(OperationType.Outcome) + total(OperationType.Debtor));
  }

  getOperations() async {
    operations.assignAll(await db.getAllOperations(Filter()));
  }

  @override
  onInit(){
    super.onInit();
    getOperations();
  }

  filterButton(){
    // Get.toNamed(AppRoutes.filter);
    Get.dialog(FilterView(),barrierDismissible: false);
  }

  final touchedIndex = (-1).obs;
}