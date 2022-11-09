import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_managment/app/core/extensions/num_extension.dart';
import 'package:money_managment/app/core/values/app_strings.dart';
import 'package:money_managment/app/core/values/app_themes.dart';
import 'package:money_managment/app/data/db/db.dart';
import 'package:money_managment/app/modules/home/controller/home_controller.dart';
import 'package:money_managment/app/core/values/app_constant.dart';

import '../../../../main.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_constant.dart';

class DetailsBottomSheet extends GetView<HomeController> {
  const DetailsBottomSheet(this.operation, this.remain, {Key? key}) : super(key: key);

  final Operation operation;
  final int remain;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.addForm,
      child: BottomSheet(
        backgroundColor: filterBackgroundColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(AppConstant.radius))
        ),
        builder: (context) {
          return Padding(
            padding: AppConstant.pagePadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(operation.description??AppString.noDescription.tr,textAlign: TextAlign.center,style: TextStyle(color: textColor,fontSize: 18,fontWeight: FontWeight.bold)),
                const SizedBox(height: AppConstant.paddingValue),
                StreamBuilder<List<DebtorAndCreditor>>(
                   stream: db.watchDebtorAndCreditor(operation.id!),
                   builder: (context, snapshot) {
                     final debtorAndCreditors = snapshot.data ?? [];
                     return Padding(
                       padding: AppConstant.pagePadding,
                       child: Column(
                         children: [
                           for(var debtorAndCreditor in debtorAndCreditors)
                             Container(
                               decoration: BoxDecoration(border: Border.all(color: detailsBottomSheetBorderColor)),
                               padding: AppConstant.pagePadding,
                               margin: EdgeInsets.fromLTRB(0, 0, 0, AppConstant.paddingValue/2),
                               child: Row(
                                 children: [
                                   Text(debtorAndCreditor.amount.withComma.toString(),style: TextStyle(fontSize: 16, color: textColor)),
                                   const Spacer(),
                                   Text(debtorAndCreditor.date.year.toString(),style: TextStyle(fontSize: 15,color: menuTextColor)),
                                   Text("-",style: TextStyle(fontSize: 15,color: menuTextColor)),
                                   Text(debtorAndCreditor.date.month.toString(),style: TextStyle(fontSize: 15,color: menuTextColor)),
                                   Text("-",style: TextStyle(fontSize: 15,color: menuTextColor)),
                                   Text(debtorAndCreditor.date.day.toString(),style: TextStyle(fontSize: 15,color: menuTextColor)),
                                   Text("\t",style: TextStyle(fontSize: 15,color: menuTextColor)),
                                   Text(debtorAndCreditor.date.hour.toString(),style: TextStyle(fontSize: 15,color: menuTextColor)),
                                   Text(":",style: TextStyle(fontSize: 15,color: menuTextColor)),
                                   Text(debtorAndCreditor.date.minute.toString(),style: TextStyle(fontSize: 15,color: menuTextColor)),
                                 ],
                               ),
                             ),
                         ],
                       ),
                     );
                   },
                 )
              ],
            ),
          );
        },
        onClosing: (){},
      ),
    );
  }
}