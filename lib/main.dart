import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'app.dart';
import 'app/data/db/db.dart';
final db = MyDatabase();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const App());
}
