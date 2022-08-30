import 'package:drift/drift.dart';

@DataClassName("Category")
class Categories extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get type => text()();

  @override
  Set<Column> get primaryKey => {id};
}
