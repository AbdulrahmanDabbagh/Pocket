import 'package:drift/drift.dart';
import 'categories.dart';

class Operations extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  TextColumn get type => text()();
  IntColumn get amount => integer()();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  TextColumn get description => text()();
  IntColumn get catId => integer().references(Categories, #id)();

  @override
  Set<Column> get primaryKey => {id};
// TextColumn get title => text().withLength(min: 6, max: 32)();
  // TextColumn get content => text().named('body')();
  // IntColumn get category => integer().nullable()();

}
