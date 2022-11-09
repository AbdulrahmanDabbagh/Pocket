import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:get/get.dart';

// import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';
import 'package:money_managment/app/core/utils/app_storage.dart';

import '../../../router/app_routes.dart';

class SplashController extends GetxController {
  @override
  onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 2));
    if (AppStorage().read(AppStorage.intro) == null) {
      Get.offNamed(AppRoutes.onboardingPage);
      AppStorage().write(AppStorage.intro, true);
    } else {
      Get.offNamed(AppRoutes.home);
    }
    if (AppStorage().read(AppStorage.hasPassword) == true) {
      screenLock(
        context: Get.overlayContext!,
        correctString: AppStorage().read(AppStorage.pinCode),
        digits: AppStorage().read(AppStorage.digits),
        canCancel: false,

        // confirmation: true,

        // didConfirmed: (value){
        //   print(value);
        //   Get.back();
        // },
        customizedButtonChild: Icon(
          Icons.fingerprint,
        ),
        customizedButtonTap: () async {
          print("customizedButtonTap");
          if(await localAuth(Get.overlayContext!))
            {
              Get.back();
            }
        },
        // didOpened: () async {
        //   print("didOpened");
        //   await localAuth(Get.overlayContext!);
        // },
      );
    }
  }

  Future<bool> localAuth(BuildContext context) async {
    // AppStorage().write(AppStorage.hasPassword, true);
    // AppStorage().write(AppStorage.pinCode, "5416561");
    final localAuth = LocalAuthentication();
    final didAuthenticate = await localAuth.authenticate(
        localizedReason: 'Please authenticate', options: const AuthenticationOptions(biometricOnly: true));
    return didAuthenticate;
  }
}
