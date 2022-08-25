import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:money_managment/app/core/values/app_colors.dart';
import 'package:money_managment/app/core/values/app_strings.dart';
import 'package:money_managment/app/modules/home/view/bottom_navigation_bar.dart';
import 'package:money_managment/app/modules/search/view/search_view.dart';
import 'package:money_managment/app/router/app_routes.dart';
import '../../../../main.dart';
import '../../../core/values/translation/app_translation.dart';
import '../../../data/db/db.dart';
import '../controller/home_controller.dart';
import 'operations_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Money Manager"),
        actions: [
          PopupMenuButton(
              itemBuilder: (_){
                return <PopupMenuEntry>[
                  PopupMenuItem(
                    value: 1,
                    child: Text(AppString.Search.tr),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Text(AppString.Payoff.tr),
                  ),
                  PopupMenuItem(
                    value: 3,
                    child: Text(AppString.Earning.tr),
                  ),
                  PopupMenuItem(
                    value: 4,
                    child: Text(AppString.Dashboard.tr),
                  ),
                  PopupMenuItem(
                    value: 5,
                    child: Text(AppString.Language.tr),
                  )
                ];
              },
            onSelected: (value){
                if(value == 1){
                  controller.searchButton();

                }else if(value == 2){

                }else if(value == 3){

                }else if(value == 4){
                  controller.dashBoardButton();
                }else if(value == 5){
                  final locale = AppTranslation.isArabic
                      ? AppTranslation.englishLocale
                      : AppTranslation.arabicLocale;
                  Get.locale = locale;
                  AppTranslation.saveLocale(locale);
                  Get.forceAppUpdate();
                }
            },
          )
        ] ,
      ),
      body: Obx((){
          return StreamBuilder<List<Operation>>(
            stream: db.watchOperations(controller.currentPage.value),
            builder: (context, snapshot) {
              final operations = snapshot.data ?? [];
              return ListView.builder(
                itemCount: operations.length,
                  itemBuilder: (context, index){
                    return OperationsCard(operation: operations[index]);
                  },

              );
            }
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // Get.toNamed("page", arguments: operation); /// from home
          // final operation = Get.arguments as Operation?; /// from add controller
          Get.toNamed(AppRoutes.add);

        },
        child:
        Icon(Icons.add , color: AppColors.number4),
        backgroundColor: AppColors.number2,
      ),
      bottomNavigationBar: BNB(),
    );

  }
}
