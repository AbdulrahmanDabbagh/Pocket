import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_managment/app/components/filter/controller/filter_controller.dart';
import 'package:money_managment/app/core/enum/type_enum.dart';
import 'package:money_managment/app/data/db/db.dart';
import 'package:money_managment/app/data/models/filter.dart';
import '../../../../main.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_constant.dart';
import '../../../core/values/app_strings.dart';

class FilterView extends StatelessWidget {
  const FilterView({Key? key, required this.filter}) : super(key: key);
  final Filter filter;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FilterController(filter));
    return Dialog(
      child: Padding(
        padding: AppConstant.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppString.Filter.tr,
              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppString.from.tr),
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith((states) => AppColors.number3),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppConstant.radius),
                                side: const BorderSide(color: AppColors.number3))),
                          ),
                          child: Center(
                            child: Text(DateFormat('yyyy-MM-dd').format(controller.fromDate.value),
                                style: const TextStyle(color: AppColors.white)),
                          ),
                          onPressed: () async {
                            final date = await showDatePicker(
                                context: context,
                                initialDate: controller.fromDate.value,
                                firstDate: controller.allOperations.first.date,
                                lastDate: controller.endDate.value);
                            if (date != null) {
                              controller.fromDate(date);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppConstant.paddingValue),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppString.to.tr),
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith((states) => AppColors.number3),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppConstant.radius),
                                side: const BorderSide(color: AppColors.number3))),
                          ),
                          child: Center(
                            child: Text(DateFormat('yyyy-MM-dd').format(controller.endDate.value),
                                style: const TextStyle(color: AppColors.white)),
                          ),
                          onPressed: () async {
                            final date = await showDatePicker(
                                context: context,
                                initialDate: controller.endDate.value,
                                firstDate: controller.fromDate.value,
                                lastDate: controller.allOperations.last.date);
                            if (date != null) {
                              controller.endDate(date);
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              );
            }),
            const SizedBox(
              height: AppConstant.paddingValue,
            ),
            const Text(
              "Select types",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: AppConstant.paddingValue / 2,
            ),
            Wrap(
              spacing: AppConstant.paddingValue / 2,
              runSpacing: AppConstant.paddingValue / 2,
              children: [
                _typeChip(OperationType.Outcome),
                _typeChip(OperationType.Income),
                _typeChip(OperationType.Creditor),
                _typeChip(OperationType.Debtor),
              ],
            ),
            const SizedBox(height: AppConstant.paddingValue),
            Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.selectedTypes.isNotEmpty)
                    const Text(
                      "Select categories",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  if (controller.selectedTypes.isNotEmpty)
                    const SizedBox(
                      height: AppConstant.paddingValue / 2,
                    ),
                  StreamBuilder<List<Category>>(
                      stream: db.watchCategoriesTypes(controller.selectedTypes.map((e) => e.name).toList()),
                      builder: (context, snapshot) {
                        final categories = snapshot.data ?? [];
                        return Wrap(
                          spacing: AppConstant.paddingValue / 2,
                          runSpacing: AppConstant.paddingValue / 2,
                          children: categories.map((e) {
                            return Obx(() {
                              final isSelected = controller.selectedCategories.any((element) => element == e);
                              return ChoiceChip(
                                label: Text(
                                  e.name,
                                  style: TextStyle(color: isSelected ? AppColors.white : null),
                                ),
                                selected: isSelected,
                                selectedColor: AppColors.number3,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                onSelected: (a) {
                                  if (isSelected) {
                                    controller.selectedCategories.remove(e);
                                  } else {
                                    controller.selectedCategories.add(e);
                                  }
                                },
                              );
                            });
                          }).toList(),
                        );
                      }),
                ],
              );
            }),
            const SizedBox(
              height: AppConstant.paddingValue,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: AppColors.white, shadowColor: Colors.transparent, onPrimary: AppColors.blue, elevation: 0),
                    child: Text(AppString.Cancel.tr),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        final filter = Filter(
                            from: controller.fromDate.value,
                            to: controller.endDate.value,
                            catIds: controller.selectedCategories.map((element) => element.id!).toList(),
                            types: controller.selectedTypes.map((element) => element.name).toList());
                        Get.back(result: filter);
                      },
                      child: Text(AppString.Apply.tr)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _typeChip(OperationType type) {
    final controller = Get.find<FilterController>();
    return Obx(() {
      final isSelected = controller.selectedTypes.any((element) => element == type);
      return ChoiceChip(
        label: Text(
          type.name.tr,
          style: TextStyle(color: isSelected ? AppColors.white : null),
        ),
        selected: isSelected,
        selectedColor: AppColors.number3,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onSelected: (a) {
          if (isSelected) {
            controller.selectedTypes.remove(type);
            controller.selectedCategories.removeWhere((element) => element.type == type.name);
          } else {
            controller.selectedTypes.add(type);
          }
        },
      );
    });
  }
}
