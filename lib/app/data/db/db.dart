import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:money_managment/app/data/tables/debtor_t.dart';
import 'package:money_managment/app/data/tables/future_goals_t.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../models/filter.dart';
import '../tables/categories.dart';
import '../tables/operations_t.dart';

part 'db.g.dart';

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory(); // data/aaa/a/affff/
    final file = File(p.join(dbFolder.path, 'db.sqlite')); // file(data/aaa/a/affff/db.sqlite);
    return NativeDatabase(file,logStatements: true);
  });
}

@DriftDatabase(tables: [Operations, Categories, DebtorAndCreditors, FutureGoals])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  Future<int> addCategory(Category category) => into(categories).insert(category);
  Future<int> addOperations(Operation operation) => into(operations).insert(operation);
  Future<int> addDebtorAndCreditor(DebtorAndCreditor debtorAndCreditor) => into(debtorAndCreditors).insert(debtorAndCreditor);
  Future<int> addFutureGoal(FutureGoal futureGoal) => into(futureGoals).insert(futureGoal);

  Future<int> removeOperation(Operation operation) => delete(operations).delete(operation);
  Future<int> removeCategory(Category category) => delete(categories).delete(category);
  Future<int> removeFutureGoal(FutureGoal futureGoal) => delete(futureGoals).delete(futureGoal);
  deleteAllCategoriesRow() async{
  const query = """
    delete from categories
    """;
  await customSelect(query).get();
  }
  deleteAllDebtorAndCreditorRow() async{
    const query = """
    delete from debtorAndCreditors
    """;
    await customSelect(query).get();
  }
  deleteAllFutureGoalsRow() async{
    const query = """
    delete from futureGoals
    """;
    await customSelect(query).get();
  }
  deleteAllOperationRow() async{
    const query = """
    delete from operations
    """;
    await customSelect(query).get();
  }
  Future<bool> editOperation(Operation operation) => update(operations).replace(operation);
  Future<bool> editCategory(Category category) => update(categories).replace(category);
  Future<bool> editFutureGoal(FutureGoal futureGoal) => update(futureGoals).replace(futureGoal);

  Stream<List<Category>> watchCategories() => select(categories).watch();
  Stream<List<Category>> watchCategoriesType(String type) => (select(categories)..where((tbl) => tbl.type.equals(type))).watch();
  Stream<List<Category>> watchCategoriesTypes(List<String> types) => (select(categories)..where((tbl) => tbl.type.isIn(types))).watch();
  Stream<List<Operation>> watchOperations(String type) => (select(operations)..where((tbl) => tbl.type.equals(type))).watch();
  Stream<List<FutureGoal>> watchFutureGoals() => select(futureGoals).watch();

  Future<List<Category>> getCategoriesType(String type) => (select(categories)..where((tbl) => tbl.type.equals(type))).get();
  Future<List<Category>> searchCategories(String type, String category) => (select(categories)..where((tbl) => tbl.type.equals(type))..where((tbl) => tbl.name.equals(category))).get();
  Future<List<Category>> getCategories(String category) => (select(categories)..where((tbl) => tbl.name.equals(category))).get();

  Future<List<Operation>> getAllOperations() {
    return (select(operations)..orderBy([(t) => OrderingTerm(expression: t.date)])).get();
  }

  Stream<List<DebtorAndCreditor>> watchDebtorAndCreditor(int operationId) => (select(debtorAndCreditors)..where((tbl) => tbl.operationId.equals(operationId))).watch();
  Future<int?> getTotalPaidDebtor() async {
    const query = """
    select sum(d.amount) from debtor_and_creditors d, operations o
    WHERE o.id = d.operation_id
    AND o.type = 'Debtor'
    """;
    final result = await customSelect(query).get();
    return result.first.data.values.first;
  }

  Future<int?> getTotalEarnCreditor() async{
    const query = """
    select sum(d.amount) from debtor_and_creditors d, operations o
    WHERE o.id = d.operation_id
    AND o.type = 'Creditor'
    """;
    final result = await customSelect(query).get();
    return result.first.data.values.first;
  }

  // Future<List<Category>> filterCategory(Type type) => (select(categories)..where((tbl) => tbl.type.equals(type))).get();
  Stream<List<Operation>> watchFilterOperations(Filter filter) {
    final query = select(operations);
    if(filter.search != null){
      if(int.tryParse(filter.search!) != null) {
        query.where((tbl) => tbl.amount.cast<String>().contains(filter.search!));
      } else {
        query.where((tbl) => tbl.description.contains(filter.search!));
      }
    }
    if(filter.from != null) {
      query.where((tbl) => tbl.date.isBetween(Variable<DateTime>(filter.from), Variable<DateTime>(filter.to!.add(Duration(hours: 23,minutes: 59)))));
    }
    if(filter.catIds.isEmpty && filter.types.isNotEmpty){
      query.where((tbl) => tbl.type.isIn(filter.types));
    } else if(filter.catIds.isNotEmpty){
      query.where((tbl) => tbl.catId.isIn(filter.catIds));
    }
    query.orderBy([(t) => OrderingTerm(expression: t.date)]);
    return query.watch();
  }

  Future<List<Operation>> getFilterOperations(Filter filter) {
    final query = select(operations);
    if(filter.search != null){
      if(int.tryParse(filter.search!) != null) {
        query.where((tbl) => tbl.amount.cast<String>().contains(filter.search!));
      } else {
        query.where((tbl) => tbl.description.contains(filter.search!));
      }
    }
    if(filter.from != null) {
      query.where((tbl) => tbl.date.isBetween(Variable<DateTime>(filter.from), Variable<DateTime>(filter.to!.add(Duration(hours: 23,minutes: 59)))));
    }
    if(filter.catIds.isEmpty && filter.types.isNotEmpty){
      query.where((tbl) => tbl.type.isIn(filter.types));
    } else if(filter.catIds.isNotEmpty){
      query.where((tbl) => tbl.catId.isIn(filter.catIds));
    }
    query.orderBy([(t) => OrderingTerm(expression: t.date)]);
    return query.get();
  }
  // Future<Category> getCategory(int id){
  //   return (select(categories)..where((tbl) => tbl.id.equals(id))).getSingle();
  // }

  Future<Category> getCategory(int id){
    // customSelect("SELECT * FROM categories WHERE id = $id").get().then((v){
    //   print(v.first.data);
    // });
    return (select(categories)..where((tbl) => tbl.id.equals(id))).getSingle();
  }



  // you should bump this number whenever you change or add_operation a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;

}

