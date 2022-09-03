import 'package:flutter/material.dart';

import '../core/values/app_colors.dart';

class AppLoadingOverlay extends StatelessWidget {
  const AppLoadingOverlay({Key? key, required this.child, required this.isLoading}) : super(key: key);
  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if(isLoading)
          const ColoredBox(
            color: AppColors.number4,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
      ],
    );
  }
}
