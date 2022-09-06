import 'package:drift/drift.dart';
import 'categories.dart';

class FutureGoals extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  IntColumn get amount => integer()();
  TextColumn get description => text()();

  @override
  Set<Column> get primaryKey => {id};
}
