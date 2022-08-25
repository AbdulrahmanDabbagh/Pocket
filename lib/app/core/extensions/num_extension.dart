import 'package:intl/intl.dart';

extension NumEx on num{
  static final format = NumberFormat("###,###.0#", "en_US");

  String get withComma{
    final result = format.format(this).split(".").first;
    return result.isEmpty ? "0": result;
  }

}