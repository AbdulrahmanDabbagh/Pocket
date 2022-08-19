import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:money_managment/data/tables/categories.dart';
import 'package:money_managment/data/tables/operations_t.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'db.g.dart';

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory(); // data/aaa/a/affff/
    final file = File(p.join(dbFolder.path, 'db.sqlite')); // file(data/aaa/a/affff/db.sqlite);
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Operations, Categories])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  Future<int> addCategory(Categorie category) => into(categories).insert(category);
  Future<int> addOperations(Operation operation) => into(operations).insert(operation);

  Future<int> removeOperation(Operation operation) => delete(operations).delete(operation);
  Future<int> removeCategory(Categorie category) => delete(categories).delete(category);

  Stream<List<Categorie>> watchCategories() => select(categories).watch();
  Stream<List<Operation>> get watchOperations => select(operations).watch();

  Future<Categorie> getCategory(int id){
    return (select(categories)..where((tbl) => tbl.id.equals(id))).getSingle();
  }
  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;
}
