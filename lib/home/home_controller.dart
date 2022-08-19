import 'package:get/get.dart';

import '../data/db/db.dart';

class HomeController{
  Rx<Categorie?> selectedCategory = Rx(null);
  Rx<DateTime> selectedDate = Rx(DateTime.now());

}