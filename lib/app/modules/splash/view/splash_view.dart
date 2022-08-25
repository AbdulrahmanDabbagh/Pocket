import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../controller/splash_controller.dart';

class SplashView extends GetView<SplashController>{
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return const Scaffold(
      body: Center(
        child: FlutterLogo(),
      ),
    );
  }
}