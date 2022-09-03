import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_managment/app/components/app_loading_overlay.dart';
import 'package:money_managment/app/components/text_field_widget.dart';
import 'package:money_managment/app/core/utils/app_validator.dart';
import 'package:money_managment/app/core/values/app_constant.dart';
import 'package:money_managment/app/modules/login/controller/login_controller.dart';

import '../../../core/values/app_strings.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx((){
        return AppLoadingOverlay(
          isLoading: controller.isLoading.value,
          child: Scaffold(
            body: Padding(
              padding: AppConstant.pagePadding,
              child: Form(
                key: controller.form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FlutterLogo(size: 70,),
                    const SizedBox(height: 50,),
                    TextFieldWidget(
                      label: AppString.usernameOrEmail.tr,
                      validator: AppValidator.required,
                      onChanged: (value) => controller.username = value,
                    ),
                    const SizedBox(height: 20,),
                    Obx(() {
                      return TextFieldWidget(
                        label: AppString.password.tr,
                        onChanged: (value) => controller.password = value,
                        obscure: !controller.isShowPassword.value,
                        validator: AppValidator.required,
                        suffixIcon: IconButton(
                          icon: Icon(controller.isShowPassword.value
                          ? CupertinoIcons.eye : CupertinoIcons.eye_slash),
                          onPressed: (){
                            controller.isShowPassword(!controller.isShowPassword.value);
                          },
                          padding: EdgeInsets.zero,
                          splashRadius: 1,
                        ),
                      );
                    }),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                        onPressed: (){
                          if(controller.form.currentState!.validate()){
                            controller.loin();
                          }
                        },
                        child: Center(child: Text(AppString.login.tr))
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
