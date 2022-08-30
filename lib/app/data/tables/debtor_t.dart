import 'package:drift/drift.dart';
import 'operations_t.dart';

class DebtorAndCreditors extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  IntColumn get operationId => integer().references(Operations, #id)();
  IntColumn get amount => integer()();
  DateTimeColumn get date => dateTime()();


}
