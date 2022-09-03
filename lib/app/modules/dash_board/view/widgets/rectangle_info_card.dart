import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_managment/app/core/extensions/num_extension.dart';
import 'package:money_managment/app/core/values/app_strings.dart';
import '../../../../core/values/app_constant.dart';

class RectangleInfoCard extends StatelessWidget {
  const RectangleInfoCard({Key? key,this.title,required this.subtitle1, required this.subtitle2, required this.amount1, required this.amount2})
      : super(key: key);
  final String? title;
  final String subtitle1;
  final String subtitle2;
  final num amount1;
  final num amount2;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        // side: BorderSide(color: AppColors.number3),
          borderRadius: BorderRadius.circular(AppConstant.radius)),
      margin: EdgeInsets.zero,
      // color: AppColors.number2,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            if(title != null)
              const SizedBox(height: 5),
            if(title != null)
              Text(title!, textAlign: TextAlign.center,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  subtitle1,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "${amount1.withComma} ${AppString.sp.tr}",
                  style: const TextStyle(fontSize: 20),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  subtitle2,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text("${amount2.withComma} ${AppString.sp.tr}",
                    style: const TextStyle(fontSize: 20))
              ],
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
