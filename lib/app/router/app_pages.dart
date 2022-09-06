import 'package:get/get.dart';
import 'package:money_managment/app/modules/add_future_goal/binding/add_future_goal_binding.dart';
import 'package:money_managment/app/modules/add_future_goal/view/add_future_goal_view.dart';
import 'package:money_managment/app/modules/dash_board/binding/dash_board_binding.dart';
import 'package:money_managment/app/modules/dash_board/view/dash_board_view.dart';
import 'package:money_managment/app/modules/future_goal/binding/future_goal_binding.dart';
import 'package:money_managment/app/modules/future_goal/view/future_goal_view.dart';
import 'package:money_managment/app/modules/home/binding/home_binding.dart';
import 'package:money_managment/app/modules/home/view/home_page.dart';
import 'package:money_managment/app/modules/login/binding/login_binding.dart';
import 'package:money_managment/app/modules/login/view/login_view.dart';
import 'package:money_managment/app/modules/profile/binding/profile_binding.dart';
import 'package:money_managment/app/modules/profile/view/profile_view.dart';
import 'package:money_managment/app/modules/search/binding/search_binding.dart';
import 'package:money_managment/app/modules/search/view/search_view.dart';
import 'package:money_managment/app/modules/splash/binding/splash_binding.dart';
import 'package:money_managment/app/modules/splash/view/splash_view.dart';
import 'package:money_managment/app/router/app_routes.dart';


import '../modules/add_operation/binding/add_binding.dart';
import '../modules/add_operation/view/add_view.dart';

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
      name: AppRoutes.dash_board,
      page: () => const DashBoardView(),
      binding: DashBoardBinding(),
    ),
    GetPage(
      name: AppRoutes.addOperation,
      page: () => const AddView(),
      binding: AddBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.futureGoal,
      page: () => const FutureGoalView(),
      binding: FutureGoalBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.addFutureGoal,
      page: () => const AddFutureGoalView(),
      binding: AddFutureGoalbinding(),
    ),
  ];
}