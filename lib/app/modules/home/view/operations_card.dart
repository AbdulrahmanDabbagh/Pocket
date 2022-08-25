import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_managment/app/core/values/app_strings.dart';
import 'package:money_managment/app/modules/home/controller/home_controller.dart';
import 'package:money_managment/app/modules/home/view/home_page.dart';
import 'package:money_managment/app/router/app_routes.dart';
import '../../../../main.dart';
import '../../../data/db/db.dart';

class OperationsCard extends GetView<HomeController> {
  const OperationsCard({Key? key, required this.operation}) : super(key: key);
  final Operation operation;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (detials){
        // print(detials.globalPosition);
        print(detials.globalPosition.dy);
        showMenu(
            context: context,
            position: RelativeRect.fromLTRB(detials.localPosition.dx, detials.globalPosition.dy, detials.localPosition.dx, detials.localPosition.dy),
            items: [
               PopupMenuItem(
                value: 1,
                child: Text(AppString.Details.tr),
                onTap: () async {
                  await Future.delayed(Duration(milliseconds: 50));
                  Get.showSnackbar(GetSnackBar(
                    message: operation.description,
                    icon: IconButton(
                      icon: Icon(Icons.clear_rounded),
                      color: Colors.white,
                      onPressed: ()=> Get.back(),
                    ),
                  ));
                 },
              ),
               PopupMenuItem(
                value: 2,
                child: Text(AppString.Edit.tr),
                 onTap: () async {
                  await Future.delayed(Duration(milliseconds: 50));
                  Get.toNamed(AppRoutes.add,arguments: Operation);
                 },
              ),
               PopupMenuItem(
                value: 3,
                child: Text(AppString.Delete.tr),
                onTap: (){
                  db.removeOperation(operation);
                },
              ),
            ],


        );
      },
      child: Card(
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(operation.amount.toString() ,
                  style: TextStyle(fontSize: 22),
                ),
              //Text(operation.description),
            ],
          ),
          subtitle: Text(DateFormat("yyyy/MM/dd").format(operation.date)),
          trailing: Container(
            child: FutureBuilder<Categorie>(
              future: db.getCategory(operation.catId),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const SizedBox();
                }
                final category = snapshot.data;
                return Text(category!.name);
              },
            ),
          ),

          ),

        ),
      );
  }
}
