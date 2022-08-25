import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_managment/app/core/values/app_colors.dart';
import 'package:money_managment/app/core/values/app_constant.dart';
import 'package:money_managment/app/core/values/app_strings.dart';

import '../../../../main.dart';
import '../../../core/enum/type_enum.dart';
import '../../../data/db/db.dart';
import '../controller/add_controller.dart';

class AddView extends GetView<AddController> {
  const AddView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.addOperation.tr , style: const TextStyle(color: AppColors.white)),
        actions: [
          IconButton(onPressed: Get.back, icon: const Icon(Icons.delete_outline),color: AppColors.white,)
        ],
      ),
      body: Form(
        key: controller.addForm,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: Padding(
              padding: AppConstant.pagePadding,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstant.radius),
                          borderSide: BorderSide(color: AppColors.number3)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstant.radius),
                          borderSide: BorderSide(color: AppColors.number2)),
                      hintText: AppString.amount.tr,
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    onChanged: (v) => controller.amount = v,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppConstant.paddingValue),
                  Obx(() {
                    return Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.resolveWith(
                                      (states) => AppColors.number3),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(AppConstant.radius),
                                  side: const BorderSide(color: AppColors.number3))),
                            ),
                            child: Text(
                                DateFormat('yyyy-MM-dd')
                                    .format(controller.selectedDate.value),
                                style: TextStyle(color: AppColors.white)),
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
                          ),
                        )
                      ],
                    );
                  }),
                  const SizedBox(height: AppConstant.paddingValue),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstant.radius),
                          borderSide: BorderSide(color: AppColors.number3)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstant.radius),
                          borderSide: BorderSide(color: AppColors.number2)),
                      hintText: AppString.amount.tr,
                    ),
                    hint: Text(AppString.selectAType.tr),
                    isExpanded: true,
                    validator: (type) {
                      if (type == null) {
                        return "required";
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
                        controller.type = string;
                      }
                    },
                  ),
                  const SizedBox(height: AppConstant.paddingValue),
                  StreamBuilder<List<Categorie>>(
                      stream: db.watchCategories(),
                      builder: (_, snapshot) {
                        final categories = snapshot.data ?? [];
                        return Obx(() {
                          final selectedCategory = controller.selectedCategory.value;
                          return DropdownButtonFormField<Categorie>(
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppConstant.radius),
                                  borderSide: BorderSide(color: AppColors.number3)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppConstant.radius),
                                  borderSide: BorderSide(color: AppColors.number2)),
                            ),
                            hint:  Text(AppString.selectACategory.tr),
                            isExpanded: true,
                            value: categories.isEmpty ? null : controller.selectedCategory.value,
                            validator: (Categorie? category) {
                              if (category == null) {
                                return "required";
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
                                value: Categorie(id: -1, name: ""),
                                child:  Text(AppString.addNewCategory.tr),
                              ),
                            ],
                            onChanged: (Categorie? category) {
                              if (category!.id == -1) {
                                late String value;
                                final form = GlobalKey<FormState>();
                                Get.bottomSheet(Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(15.0))),
                                  padding: const EdgeInsets.all(10),
                                  child: Form(
                                    key: form,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: AppString.categoryName.tr,
                                          suffixIcon: IconButton(
                                            icon: Icon(Icons.add),
                                            onPressed: () {
                                              if (form.currentState!.validate()) {
                                                db.addCategory(
                                                    Categorie(name: value));
                                                Get.back();
                                              }
                                            },
                                          )),
                                      onChanged: (v) => value = v,
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return "required";
                                        }
                                        if (categories.any((element) =>
                                            element.name.trim() == value.trim())) {
                                          return AppString.thiscategoryIsExist.tr;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ));
                              } else {
                                controller.selectedCategory.value = category;
                              }
                            },
                          );
                        });
                      }),
                  const SizedBox(height: AppConstant.paddingValue),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstant.radius),
                          borderSide: BorderSide(color: AppColors.number3)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstant.radius),
                          borderSide: BorderSide(color: AppColors.number2)),
                      hintText: AppString.description.tr,
                    ),
                    onChanged: (v) => controller.description = v,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppConstant.paddingValue),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppConstant.radius),
                                side: const BorderSide(color: AppColors.number3))),
                            backgroundColor: MaterialStateProperty.resolveWith((states) => AppColors.number3)
                          ),
                          child: Text(AppString.add.tr,style: TextStyle(color: AppColors.white)),
                          onPressed: () {
                            if (controller.addForm.currentState!.validate()) {
                              db.addOperations(Operation(
                                  type: controller.type,
                                  amount: int.parse(controller.amount),
                                  date: controller.selectedDate.value,
                                  description: controller.description,
                                  catId: controller.selectedCategory.value!.id!));
                              Get.back();
                            }
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
