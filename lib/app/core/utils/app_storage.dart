import 'package:get_storage/get_storage.dart';

class AppStorage{
  final _box = GetStorage();
  static const token = "token";
  static const isDarkTheme = "isDarkTheme";
  static const locale = "locale";

  T? read<T>(String key){
    return _box.read(key);
  }

  write(String key, dynamic value){
    return _box.write(key,value);
  }

  clearAll() {
    return _box.erase();
  }

}