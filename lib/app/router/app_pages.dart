import 'package:get/get.dart';
import 'package:money_managment/app/modules/dash_board/binding/dash_board_binding.dart';
import 'package:money_managment/app/modules/dash_board/view/dash_board_view.dart';
import 'package:money_managment/app/modules/filter/view/filter_view.dart';
import 'package:money_managment/app/modules/home/binding/home_binding.dart';
import 'package:money_managment/app/modules/home/view/home_page.dart';
import 'package:money_managment/app/modules/search/binding/search_binding.dart';
import 'package:money_managment/app/modules/search/view/search_view.dart';
import 'package:money_managment/app/modules/splash/binding/splash_binding.dart';
import 'package:money_managment/app/modules/splash/view/splash_view.dart';
import 'package:money_managment/app/router/app_routes.dart';

import '../modules/add/binding/add_binding.dart';
import '../modules/add/view/add_view.dart';
import '../modules/filter/binding/filter_binding.dart';

class AppPages{
  static const initialRoute = AppRoutes.splash;

  static final pages = <GetPage>[
    GetPage(
        name: AppRoutes.home,
        page: () => const HomePage(),
        binding: HomeBinding()),
    GetPage(
        name: AppRoutes.splash,
        page: () => const SplashView(),
        binding: SplashBinding()),
    GetPage(
        name: AppRoutes.search,
        page: () => const SearchView(),
        binding: SearchBinding(),
    ),
    GetPage(
      name: AppRoutes.filter,
      page: () => const FilterView(),
      binding: FilterBinding(),
    ),
    GetPage(
      name: AppRoutes.dash_board,
      page: () => const DashBoardView(),
      binding: DashBoardBinding(),
    ),
    GetPage(
      name: AppRoutes.add,
      page: () => const AddView(),
      binding: AddBinding(),
    ),
  ];
}