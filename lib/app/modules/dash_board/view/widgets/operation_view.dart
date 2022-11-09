import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_managment/app/core/values/app_themes.dart';
import 'package:money_managment/app/modules/dash_board/controller/dash_board_controller.dart';
import 'package:money_managment/app/modules/home/view/bottom_navigation_bar.dart';

import '../../../../../main.dart';
import '../../../../core/enum/type_enum.dart';
import '../../../../core/utils/background_image.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/app_constant.dart';
import '../../../../data/db/db.dart';
import '../../../../router/app_routes.dart';
import '../../../home/view/operations_card.dart';

class OperationView extends GetView<DashBoardController> {
  const OperationView(this.operationType, {Key? key}) : super(key: key);

  final OperationType operationType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(operationType.name.tr),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: backgroundImage,
          ),
          child: StreamBuilder<List<Operation>>(
              stream: db.watchOperations(operationType.name),
              builder: (context, snapshot) {
                final operations = snapshot.data ?? [];
                return ListView.builder(
                  padding: AppConstant.pagePadding,
                  itemCount: operations.length,
                  itemBuilder: (context, index) {
                    return OperationsCard(operation: operations[index]);
                  },
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Get.toNamed("page", arguments: operation); /// from home
            // final operation = Get.arguments as Operation?; /// from add_operation controller
            Get.toNamed(AppRoutes.addOperation);
          },
          backgroundColor: floatingActionButtonBackgroundColor,
          child: Icon(Icons.add, color: floatingActionButtonIconColor),
        ),
    );
  }
}
