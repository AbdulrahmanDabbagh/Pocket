

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_managment/app/core/extensions/num_extension.dart';
import 'package:money_managment/app/core/values/app_constant.dart';
import 'package:money_managment/app/core/values/app_strings.dart';

class RectCard extends StatelessWidget {
  const RectCard(
      {Key? key, this.title, required this.subtitle1, required this.subtitle2, required this.amount1, required this.amount2})
      : super(key: key);

  final String? title;
  final String subtitle1;
  final String subtitle2;
  final num amount1;
  final num amount2;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstant.radius)),
      margin: EdgeInsets.zero,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            if (title != null)
              Text(
                title!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        subtitle1,
                        style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold,height: 1),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        amount1.withComma,
                        style: const TextStyle(fontSize: 20,height: 1),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppString.sp.tr,
                        style: const TextStyle(fontSize: 20,height: 1),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: VerticalDivider(
                    width: 10,
                    thickness: 2,
                    indent: title == null?0:10,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        subtitle2,
                        style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold,height: 1),
                      ),
                      const SizedBox(height: 15),
                      Text(amount2.withComma,
                          style: const TextStyle(fontSize: 20,height: 1), textAlign: TextAlign.center),
                      const SizedBox(height: 8),
                      Text(AppString.sp.tr,
                          style: const TextStyle(fontSize: 20,height: 1), textAlign: TextAlign.center)
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}