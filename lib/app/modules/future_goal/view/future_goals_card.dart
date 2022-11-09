import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_managment/app/components/confirm_operation_dialog.dart';
import 'package:money_managment/app/core/enum/type_enum.dart';
import 'package:money_managment/app/core/extensions/num_extension.dart';
import 'package:money_managment/app/core/values/app_constant.dart';
import 'package:money_managment/app/core/values/app_strings.dart';
import 'package:money_managment/app/core/values/translation/app_translation.dart';
import 'package:money_managment/app/router/app_routes.dart';
import '../../../../main.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_themes.dart';
import '../../../data/db/db.dart';
import '../../add_operation/view/add_view.dart';
import '../controller/future_goal_controller.dart';

class FutureGoalCard extends GetView<FutureGoalController> {
  FutureGoalCard({Key? key, required this.futureGoal}) : super(key: key);
  final FutureGoal futureGoal;
  @override
  final controller = Get.put(FutureGoalController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (detials) {
        double start = detials.globalPosition.dx;
        if (AppTranslation.isArabic) {
          start = MediaQuery.of(context).size.width - start;
        }
        showMenu(
          color: menuBackgroundColor,
          context: context,
          position: RelativeRect.fromLTRB(start, detials.globalPosition.dy, start, detials.localPosition.dy),
          items: [
            PopupMenuItem(
              value: 1,
              child: Text(AppString.Edit.tr, style: TextStyle(color: menuTextColor)),
              onTap: () async {
                await Future.delayed(const Duration(milliseconds: 50));
                Get.toNamed(AppRoutes.addFutureGoal, arguments: futureGoal);
              },
            ),
            PopupMenuItem(
              value: 2,
              child: Text(AppString.Delete.tr, style: TextStyle(color: menuTextColor)),
              onTap: () async {
                await Future.delayed(const Duration(milliseconds: 50));
                Get.dialog(ConfirmOperationDialog(
                  confirmText: AppString.Delete.tr,
                  onConfirm: () {
                    db.removeFutureGoal(futureGoal);
                    Get.back();
                  },
                ));
                //
              },
            ),
            PopupMenuItem(
              value: 3,
              child: Text(AppString.doIt.tr, style: TextStyle(color: menuTextColor)),
              onTap: () async {
                await Future.delayed(const Duration(milliseconds: 50));
                Get.dialog(ConfirmOperationDialog(
                  confirmText: AppString.doIt.tr,
                  onConfirm: () async {
                    await Get.bottomSheet(CategoryBottomSheet(futureGoal));
                    Get.back();
                  },
                ));
                //
              },
            ),
          ],
        );
      },
      child: Card(
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    futureGoal.amount.withComma.toString(),
                    style: TextStyle(fontSize: 24, color: textColor),
                  ),
                ],
              ),
              const SizedBox(
                height: AppConstant.paddingValue,
              ),
              Row(
                children: [
                  Text(
                    futureGoal.description,
                    style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryBottomSheet extends GetView<FutureGoalController> {
  CategoryBottomSheet(this.futureGoal, {Key? key}) : super(key: key);
  @override
  final controller = Get.put(FutureGoalController());
  final FutureGoal futureGoal;
  @override
  Widget build(BuildContext context) {
    final form = GlobalKey<FormState>();
    return Container(
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
      padding: const EdgeInsets.all(10),
      child: Form(
        key: form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder<List<Category>>(
                  stream: db.watchCategoriesType(OperationType.Outcome.name),
                  builder: (_, snapshot) {
                    final categories = snapshot.data ?? [];
                    return Obx(() {
                      Category? selectedCategory = controller.selectedCategory.value;
                      return DropdownButtonFormField<Category>(
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(AppConstant.radius),
                                borderSide: BorderSide(color: AppColors.number3)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(AppConstant.radius),
                                borderSide: BorderSide(color: AppColors.number2)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(AppConstant.radius),
                                borderSide: BorderSide(color: AppColors.number2)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(AppConstant.radius), borderSide: BorderSide(color: Colors.red)),
                            fillColor: AppColors.white,
                            filled: true),
                        hint: Text(AppString.selectACategory.tr),
                        isExpanded: true,
                        value: categories.isEmpty ? null : selectedCategory,
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
                            if (newCat is Category && newCat.type == OperationType.Outcome.name) {
                              controller.selectedCategoryId(newCat.id);
                            }
                          } else {
                            controller.selectedCategoryId(category.id);
                          }
                        },
                      );
                    });
                  }
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
              onPressed: () {
                db.addOperations(Operation(
                    type: OperationType.Outcome.name,
                    amount: futureGoal.amount,
                    date: DateTime.now(),
                    description: futureGoal.description,
                    catId: controller.selectedCategoryId.value!)); //todo args
                db.removeFutureGoal(futureGoal);
                Get.back();
              },
            )
          ],
        ),
      ),
    );
  }
}
class AddCategoryBottomSheet extends GetView<FutureGoalController> {
  const AddCategoryBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String value;
    final form = GlobalKey<FormState>();
    const type = OperationType.Outcome;
    final categories = <Category>[];
    return Container(
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
      padding: const EdgeInsets.all(10),
      child: Form(
        key: form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppConstant.radius), borderSide: BorderSide(color: AppColors.number3)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppConstant.radius), borderSide: BorderSide(color: AppColors.number2)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppConstant.radius), borderSide: BorderSide(color: AppColors.number2)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppConstant.radius), borderSide: BorderSide(color: Colors.red)),
                hintText: AppString.categoryName.tr,
              ),
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
                  final category = Category(name: value, type: type.name);
                  final id = await db.addCategory(category);
                  Get.back(result: Category(id: id,name: value, type: type.name));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
