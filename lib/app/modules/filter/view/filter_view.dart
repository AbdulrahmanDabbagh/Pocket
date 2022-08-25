import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:money_managment/app/data/db/db.dart';
import 'package:money_managment/app/modules/filter/controller/filter_controller.dart';

import '../../../../main.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_constant.dart';
import '../../../core/values/app_strings.dart';
import '../../../data/models/filter.dart';

class FilterView extends GetView<FilterView> {
  const FilterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FilterController());
    return AlertDialog(
      title:  Text(AppString.Filter.tr),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx((){
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => AppColors.number3),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppConstant.radius),
                        side: const BorderSide(color: AppColors.number3))),
                  ),
                  child:Text(DateFormat('yyyy-MM-dd').format(controller.selectedStartDate.value),
                      style: TextStyle(color: AppColors.white)),
                  onPressed: () async {
                    final date = await showDatePicker(
                        context: context,
                        initialDate: controller.selectedStartDate.value,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100)
                    );
                    if(date != null){
                      controller.selectedStartDate(date);
                    }
                  },
                ),
                SizedBox(width: AppConstant.paddingValue),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => AppColors.number3),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppConstant.radius),
                        side: const BorderSide(color: AppColors.number3))),
                  ),
                  child:Text(DateFormat('yyyy-MM-dd').format(controller.selectedEndDate.value),
                      style: TextStyle(color: AppColors.white)),
                  onPressed: () async {
                    final date = await showDatePicker(
                        context: context,
                        initialDate: controller.selectedEndDate.value,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100)
                    );
                    if(date != null){
                      controller.selectedEndDate(date);
                    }
                  },
                )
                ],
              );
            }
          ),
          SizedBox(height: AppConstant.paddingValue,),
          StreamBuilder<List<Categorie>>(
              stream: db.watchCategories(),
              builder: (context, snapshot) {
                final categories = snapshot.data ?? [];
                return Wrap(
                  children: [
                    for(final category in categories)
                      ChoiceChip(
                        label: Text(category.name),
                        selected: false,
                        onSelected: (a){},

                      )
                  ],

                );
              }
          ),
          SizedBox(height: AppConstant.paddingValue,),
          Wrap(
            children: [
              ChoiceChip(
                label: Text(AppString.Outcome.tr),
                selected: false,
              ),
              SizedBox(width: AppConstant.paddingValue,),
              ChoiceChip(
                label: Text(AppString.Income.tr),
                selected: false,
              ),
              SizedBox(width: AppConstant.paddingValue,),
              ChoiceChip(
                label: Text(AppString.Creditor.tr),
                selected: false,
              ),
              SizedBox(width: AppConstant.paddingValue,),
              ChoiceChip(
                label: Text(AppString.Debtor.tr),
                selected: false,
              ),
            ],
          ),
          SizedBox(height: AppConstant.paddingValue,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed:(){
                    Get.back();
                    },
                  child:  Text(AppString.Cancel.tr),
              ),
              ElevatedButton(
                  onPressed: (){
                    final filter = Filter();
                    Get.back(result: filter);
                  }, //TODO
                  child:  Text(AppString.Apply.tr)
              )
            ],
          )
        ],
      ),
    );
  }
}
// return Dialog(
//
// child: Column(
// mainAxisSize: MainAxisSize.min,
// children: [
// Text(AppString.Filter),
// Obx((){
// return Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// TextButton(
// child:Text(DateFormat('yyyy-MM-dd').format(controller.selectedStartDate.value)),
// onPressed: () async {
// final date = await showDatePicker(
// context: context,
// initialDate: controller.selectedStartDate.value,
// firstDate: DateTime(2000),
// lastDate: DateTime(2100)
// );
// if(date != null){
// controller.selectedStartDate(date);
// }
// },
// ),
// TextButton(
// child:Text(DateFormat('yyyy-MM-dd').format(controller.selectedEndDate.value)),
// onPressed: () async {
// final date = await showDatePicker(
// context: context,
// initialDate: controller.selectedEndDate.value,
// firstDate: DateTime(2000),
// lastDate: DateTime(2100)
// );
// if(date != null){
// controller.selectedEndDate(date);
// }
// },
// )
// ],
// );
// }
// ),
// Container(
// width: 200,
// height: 1,
// decoration: BoxDecoration(
// border: Border.all(color: AppColors.blue)
// )
// ),
// Wrap(
// children: const [
// // for (category in c)
// // ChoiceChip(label: , selected: false)
// ],
// ),
// Center(child: Text("Cat")),
// Container(
// width: 200,
// height: 1,
// decoration: BoxDecoration(
// border: Border.all(color: AppColors.blue)
// )
// ),
// Wrap(
// children: const [
// // for (category in c)
// // ChoiceChip(label: , selected: false)
// ],
// ),
// Center(child: Text("Type")),
// Container(
// height: 25,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// ElevatedButton(
// onPressed:(){
// Get.back();
// },
// child: const Text(AppString.Cancel),
// ),
// ElevatedButton(
// onPressed: (){}, //TODO
// child: const Text(AppString.Apply)
// )
// ],
// )
// ],
// ),
// );