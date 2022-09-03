
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:money_managment/app/core/extensions/num_extension.dart';
import 'package:money_managment/app/core/values/app_strings.dart';

import '../../../../core/values/app_constant.dart';

class SquareInfoCard extends StatelessWidget {
  const SquareInfoCard({Key? key, required this.title, required this.amount})
      : super(key: key);
  final String title;
  final num amount;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        // side: const BorderSide(color: AppColors.number2,width: 0.2),
          borderRadius: BorderRadius.circular(AppConstant.radius)),
      elevation: 3,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: AppConstant.pagePadding,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 21,
              child: Center(
                child: AutoSizeText(
                  amount.withComma,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                  maxLines: 1,
                  maxFontSize: 20,
                ),
              ),
            ),
            const Text(AppString.sp,
                textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
