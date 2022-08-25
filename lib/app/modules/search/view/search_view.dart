import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:money_managment/app/core/values/app_constant.dart';
import 'package:money_managment/app/core/values/app_strings.dart';
import 'package:money_managment/app/modules/search/controller/search_controller.dart';

import '../../../components/text_field_widget.dart';
import '../../../core/values/app_colors.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppConstant.pagePadding,
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.arrow_back_rounded)
                  ),
                  Expanded(
                    child:
                    Obx((){
                        return TextFormField(
                          controller: controller.textSearchController.value,
                          decoration: InputDecoration(
                            hintText: AppString.Search.tr,
                            suffixIcon: controller.searchText.value.isNotEmpty?
                            IconButton(
                              onPressed: (){
                                controller.textSearchController.value.clear();
                                controller.searchText("");
                                },
                              icon: Icon(Icons.clear),
                            )
                                :null
                          ),
                          onChanged: (v)=>controller.searchText.value=v,
                        );
                      }
                    )
                    // TextFieldWidget(
                    //   hint: AppString.Search.tr,
                    //   suffixIcon:
                    //   IconButton(
                    //       onPressed: (){
                    //         controller.searchText?.value = "";
                    //       },
                    //       icon: Icon(Icons.clear),
                    //   ),
                    //   onChanged: (v)=>controller.searchText?.value=v,
                    // ),
                  ),
                ],
              )
            ],
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
