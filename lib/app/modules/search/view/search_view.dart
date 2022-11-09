import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_managment/app/core/values/app_constant.dart';
import 'package:money_managment/app/core/values/app_strings.dart';
import 'package:money_managment/app/core/values/app_themes.dart';
import 'package:money_managment/app/modules/search/controller/search_controller.dart';
import '../../../core/utils/background_image.dart';
import '../../../core/values/app_colors.dart';
import '../../home/view/operations_card.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: backgroundImage,
        ),
        child: SafeArea(
          child: Padding(
            padding: AppConstant.pagePadding,
            child: Obx(() {
              return Column(
                children: [
                  Row(
                    children: [
                      IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_rounded ,color: searchIconColor,)),
                      Expanded(
                          child: TextFormField(
                        controller: controller.textSearchController,
                        decoration: InputDecoration(
                            hintText: AppString.Search.tr,
                            hintStyle: TextStyle(color: textFieldHintStyle),
                            fillColor: textFieldFillColor,
                            filled: true,
                            suffixIcon: controller.searchText.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      controller.textSearchController.clear();
                                      controller.searchText("");
                                    },
                                    icon: Icon(Icons.clear,color: searchIconColor),
                                  )
                                : null),
                        style: TextStyle(color: textFieldHintStyle),
                        onChanged: (v) {
                          controller.searchText.value = v;
                          controller.search();
                        },
                      )),
                      const SizedBox(width: AppConstant.paddingValue / 2),
                    ],
                  ),
                  const SizedBox(height: AppConstant.paddingValue),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.operations.length,
                      itemBuilder: (context, index) {
                        return OperationsCard(operation: controller.operations[index]);
                      },
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.filterButton();
        },
        backgroundColor: floatingActionButtonBackgroundColor,
        child: Icon(Icons.filter_list, color: floatingActionButtonIconColor),
      ),
    );
  }
}
