import 'package:drift/drift.dart';

class Categories extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}
