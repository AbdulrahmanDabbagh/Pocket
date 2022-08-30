import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_managment/app/core/values/app_constant.dart';
import 'package:money_managment/app/core/values/app_strings.dart';
import 'package:money_managment/app/modules/search/controller/search_controller.dart';
import '../../../../main.dart';
import '../../../core/values/app_colors.dart';
import '../../../data/db/db.dart';
import '../../home/view/operations_card.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppConstant.pagePadding,
          child: Obx((){
              return Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(Icons.arrow_back_rounded)
                      ),
                      Expanded(
                        child:
                        TextFormField(
                              controller: controller.textSearchController,
                              decoration: InputDecoration(
                                hintText: AppString.Search.tr,
                                suffixIcon: controller.searchText.isNotEmpty?
                                IconButton(
                                  onPressed: (){
                                    controller.textSearchController.clear();
                                    controller.searchText("");
                                    },
                                  icon: Icon(Icons.clear),
                                )
                                    :null
                              ),
                              onChanged: (v) {
                                controller.searchText.value=v;
                                controller.search();
                              },
                            )
                      ),
                      const SizedBox(width: AppConstant.paddingValue/2),
                    ],
                  ),
                  const SizedBox(height: AppConstant.paddingValue),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.operations.length,
                      itemBuilder: (context, index){
                        return OperationsCard(operation: controller.operations[index]);
                      },
                    ),
                  ),
                ],
              );
            }
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.filterButton();
        },
          backgroundColor: AppColors.number4,
        child:
          const Icon(Icons.filter_list, color: AppColors.number2),
      ),
    );
  }
}
