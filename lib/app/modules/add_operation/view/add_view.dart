import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_managment/app.dart';
import 'package:money_managment/app/core/values/app_colors.dart';
import 'package:money_managment/app/core/values/app_constant.dart';
import 'package:money_managment/app/core/values/app_strings.dart';

import '../../../../main.dart';
import '../../../core/enum/type_enum.dart';
import '../../../core/utils/background_image.dart';
import '../../../core/values/app_themes.dart';
import '../../../data/db/db.dart';
import '../controller/add_controller.dart';

class AddView extends GetView<AddController> {
  const AddView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.addOperation.tr),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: backgroundImage,
        ),
        child: Form(
          key: controller.addForm,
          child: Padding(
            padding: AppConstant.pagePadding,
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstant.radius),
                          borderSide: BorderSide(color: textFieldBoarderColor)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstant.radius),
                          borderSide: BorderSide(color: textFieldBoarderColor)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstant.radius),
                          borderSide: BorderSide(color: textFieldBoarderColor)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstant.radius),
                          borderSide: BorderSide(color: Colors.red)),
                      hintText: AppString.amount.tr,
                      hintStyle: TextStyle(color: textFieldHintStyle),
                      fillColor: textFieldFillColor,
                      filled: true),
                  style: TextStyle(color: textFieldHintStyle),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  initialValue: (controller.operation?.amount ?? "").toString(),
                  onChanged: (v) => controller.amount = v,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return AppString.required.tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppConstant.paddingValue),
                Obx(() {
                  return TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith((states) => textFieldFillColor),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppConstant.radius),
                          side: BorderSide(color: textFieldBoarderColor))),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: Text(
                          DateFormat('yyyy-MM-dd').format(controller.selectedDate.value),
                          style: TextStyle(color: textFieldHintStyle, fontSize: 16),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      final date = await showDatePicker(
                          context: context,
                          initialDate: controller.selectedDate.value,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100));
                      if (date != null) {
                        controller.selectedDate(date);
                      }
                    },
                  );
                }),
                const SizedBox(height: AppConstant.paddingValue),
                Obx(() {
                  return DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppConstant.radius),
                            borderSide: BorderSide(color: textFieldBoarderColor)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppConstant.radius),
                            borderSide: BorderSide(color: textFieldBoarderColor)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppConstant.radius),
                            borderSide: BorderSide(color: textFieldBoarderColor)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppConstant.radius),
                            borderSide: BorderSide(color: Colors.red)),
                        hintStyle: TextStyle(color: textFieldHintStyle),
                        fillColor: textFieldFillColor,
                        filled: true),
                    value: controller.type.value,
                    hint: Text(AppString.selectAType.tr),
                    dropdownColor: dropDownColor,
                    style: TextStyle(color: textFieldHintStyle),
                    isExpanded: true,
                    validator: (type) {
                      if (type == null) {
                        return AppString.required.tr;
                      }
                      return null;
                    },
                    items: [
                      DropdownMenuItem(
                        value: OperationType.Income.name,
                        child: Text(AppString.Income.tr),
                      ),
                      DropdownMenuItem(
                        value: OperationType.Outcome.name,
                        child: Text(AppString.Outcome.tr),
                      ),
                      DropdownMenuItem(
                        value: OperationType.Creditor.name,
                        child: Text(AppString.Creditor.tr),
                      ),
                      DropdownMenuItem(
                        value: OperationType.Debtor.name,
                        child: Text(AppString.Debtor.tr),
                      ),
                    ],
                    onChanged: (String? string) {
                      if (string != null) {
                        controller.selectedCategory.value = null;
                        controller.type(string);
                      }
                    },
                  );
                }),
                const SizedBox(height: AppConstant.paddingValue),
                Obx(() {
                  return StreamBuilder<List<Category>>(
                      stream: db.watchCategoriesType(controller.type.value),
                      builder: (_, snapshot) {
                        final categories = snapshot.data ?? [];
                        return Obx(() {
                          Category? selectedCategory = controller.selectedCategory.value;
                          return DropdownButtonFormField<Category>(
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(AppConstant.radius),
                                    borderSide: BorderSide(color: textFieldBoarderColor)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(AppConstant.radius),
                                    borderSide: BorderSide(color: textFieldBoarderColor)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(AppConstant.radius),
                                    borderSide: BorderSide(color: textFieldBoarderColor)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(AppConstant.radius),
                                    borderSide: BorderSide(color: Colors.red)),
                                fillColor: textFieldFillColor,
                                filled: true),
                            hint: Text(AppString.selectACategory.tr ,style: TextStyle(color:textFieldHintStyle)),
                            isExpanded: true,
                            value: categories.isEmpty ? null : selectedCategory,
                            style: TextStyle(color: textFieldHintStyle),
                            dropdownColor: dropDownColor,
                            validator: (Category? category) {
                              if (category == null) {
                                return AppString.required.tr;
                              }
                              return null;
                            },
                            items: [
                              for (final category in categories)
                                DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name),
                                ),
                              DropdownMenuItem(
                                value: Category(id: -1, name: "", type: ''),
                                child: Text(AppString.addNewCategory.tr),
                              ),
                            ],
                            onChanged: (Category? category) async {
                              if (category!.id == -1) {
                                final newCat = await Get.bottomSheet(const AddCategoryBottomSheet());
                                if (newCat is Category && newCat.type == controller.type.value) {
                                  controller.selectedCategory(newCat);
                                }
                              } else {
                                controller.selectedCategory(category);
                              }
                            },
                          );
                        });
                      });
                }),
                const SizedBox(height: AppConstant.paddingValue),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstant.radius),
                          borderSide: BorderSide(color: textFieldBoarderColor)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstant.radius),
                          borderSide: BorderSide(color: textFieldBoarderColor)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstant.radius),
                          borderSide: BorderSide(color: textFieldBoarderColor)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstant.radius),
                          borderSide: BorderSide(color: Colors.red)),
                      hintText: AppString.description.tr,
                      hintStyle: TextStyle(color: textFieldHintStyle),
                      fillColor: textFieldFillColor,
                      filled: true),
                  style: TextStyle(color: textFieldHintStyle),
                  initialValue: (controller.operation?.description ?? "").toString(),
                  onChanged: (v) => v.isEmpty ? controller.description = null : controller.description = v,
                ),
                const SizedBox(height: AppConstant.paddingValue),
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppConstant.radius),
                          side: const BorderSide(color: AppColors.number3))),
                      backgroundColor: MaterialStateProperty.resolveWith((states) => AppColors.number3)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Text(controller.operation == null ? AppString.add.tr : AppString.Edit.tr,
                          style: const TextStyle(color: AppColors.white, fontSize: 16)),
                    ),
                  ),
                  onPressed: () {
                    if (controller.addForm.currentState!.validate()) {
                      if (controller.operation == null) {
                        db.addOperations(Operation(
                            type: controller.type.value,
                            amount: int.parse(controller.amount),
                            date: controller.selectedDate.value,
                            description: controller.description,
                            catId: controller.selectedCategory.value!.id!));
                      } else {
                        final editedOperation = Operation(
                            id: controller.operation!.id,
                            type: controller.type.value,
                            amount: int.parse(controller.amount),
                            date: controller.selectedDate.value,
                            description: controller.description,
                            catId: controller.selectedCategory.value!.id!);
                        db.editOperation(editedOperation);
                      }
                      Get.back();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddCategoryBottomSheet extends GetView<AddController> {
  const AddCategoryBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String value;
    final form = GlobalKey<FormState>();
    final type = controller.type.value.obs;
    final categories = <Category>[];
    return Container(
      decoration: BoxDecoration(color: filterBackgroundColor, borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
      padding: const EdgeInsets.all(10),
      child: Form(
        key: form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() {
              return DropdownButtonFormField<String>(
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppConstant.radius),
                        borderSide: BorderSide(color: textFieldBoarderColor)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppConstant.radius),
                        borderSide: BorderSide(color: textFieldBoarderColor)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppConstant.radius),
                        borderSide: BorderSide(color: textFieldBoarderColor)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppConstant.radius),
                        borderSide: BorderSide(color: textFieldBoarderColor)),
                    hintStyle: TextStyle(color: textFieldHintStyle),
                    labelStyle: TextStyle(color: textFieldHintStyle),
                    fillColor: textFieldFillColor),
                value: type.value,
                hint: Text(AppString.selectAType.tr),
                isExpanded: true,
                style: TextStyle(color: textFieldHintStyle),
                dropdownColor: dropDownColor,
                validator: (type) {
                  if (type == null) {
                    return AppString.required.tr;
                  }
                  return null;
                },
                items: [
                  DropdownMenuItem(
                    value: OperationType.Income.name,
                    child: Text(AppString.Income.tr),
                  ),
                  DropdownMenuItem(
                    value: OperationType.Outcome.name,
                    child: Text(AppString.Outcome.tr),
                  ),
                  DropdownMenuItem(
                    value: OperationType.Creditor.name,
                    child: Text(AppString.Creditor.tr),
                  ),
                  DropdownMenuItem(
                    value: OperationType.Debtor.name,
                    child: Text(AppString.Debtor.tr),
                  ),
                ],
                onChanged: (String? value) async {
                  type(value!);
                  categories.assignAll(await db.getCategoriesType(value));
                },
              );
            }),
            const SizedBox(height: AppConstant.paddingValue),
            TextFormField(
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstant.radius),
                      borderSide: BorderSide(color: textFieldBoarderColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstant.radius),
                      borderSide: BorderSide(color: textFieldBoarderColor)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstant.radius),
                      borderSide: BorderSide(color: textFieldBoarderColor)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstant.radius),
                      borderSide: BorderSide(color: textFieldBoarderColor)),
                  hintText: AppString.categoryName.tr,
                  hintStyle: TextStyle(color: textFieldHintStyle),
                  fillColor: textFieldFillColor),
              style: TextStyle(color: textFieldHintStyle),
              onChanged: (v) => value = v,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return AppString.required.tr;
                }
                if (categories.any((element) => element.name.trim() == value.trim())) {
                  return AppString.thiscategoryIsExist.tr;
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstant.paddingValue),
            ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstant.radius), side: const BorderSide(color: AppColors.number3))),
                  backgroundColor: MaterialStateProperty.resolveWith((states) => AppColors.number3)),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Text(AppString.add.tr, style: const TextStyle(color: AppColors.white, fontSize: 16)),
                ),
              ),
              onPressed: () async {
                if (form.currentState!.validate()) {
                  final category = Category(name: value, type: type.value);
                  final id = await db.addCategory(category);
                  Get.back(result: category.copyWith(id: d.Value(id)));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
