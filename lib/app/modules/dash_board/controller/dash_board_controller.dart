import 'dart:async';

import 'package:get/get.dart';
import 'package:money_managment/app/components/filter/view/filter_view.dart';
import 'package:money_managment/app/core/enum/type_enum.dart';
import 'package:money_managment/app/data/db/db.dart';
import 'package:money_managment/app/data/models/filter.dart';
import 'package:money_managment/main.dart';

import '../../../router/app_routes.dart';

class DashBoardController extends GetxController{

  final operations = <Operation>[].obs;
  Filter filter = Filter();
  StreamSubscription? listener;

  num total(OperationType operationType){
    final incomeOperations = operations.where((e) => e.type == operationType.name).toList();
    return incomeOperations.fold<int>(0,(value, element) => value + element.amount);
  }

  num get totalCash {
   final result = (total(OperationType.Income) + total(OperationType.Debtor)) - (total(OperationType.Outcome) + total(OperationType.Creditor));
   return result < 0?0:result;
  }

  num get totalBudge {
   return (total(OperationType.Income) + total(OperationType.Creditor)) - (total(OperationType.Outcome) + total(OperationType.Debtor));
  }

  List<Operation> get outcomes {
   return operations.where((e) => e.type == OperationType.Outcome.name).toList();
  }

  List<Operation> get incomes {
   return operations.where((e) => e.type == OperationType.Income.name).toList();
  }

  getOperations(){
    if(listener != null){
      listener!.cancel();
    }
    listener = db.watchFilterOperations(filter).listen(operations);
  }

  @override
  onInit(){
    super.onInit();
    db.watchFilterOperations(filter).listen(operations);
    getOperations();
  }

  filterButton() async {
    final filter = await Get.dialog(FilterView(filter: this.filter),barrierDismissible: false);
    if(filter is Filter){
      this.filter = filter;
      getOperations();
    }
  }

  final touchedIndex = (-1).obs;

  @override
  void onClose() {
    listener!.cancel();
    super.onClose();
  }
}