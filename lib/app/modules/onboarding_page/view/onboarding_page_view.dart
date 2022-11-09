import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_managment/app/modules/onboarding_page/view/widget/build_page_budget.dart';
import 'package:money_managment/app/modules/onboarding_page/view/widget/build_page_password.dart';
import 'package:money_managment/app/modules/onboarding_page/view/widget/build_page_welcome.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../main.dart';
import '../../../core/enum/type_enum.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_constant.dart';
import '../../../core/values/app_strings.dart';
import '../../../data/db/db.dart';
import '../../../router/app_routes.dart';
import '../controller/onboarding_page_controller.dart';

class OnboardingPageView extends GetView<OnboardingPageController> {
  const OnboardingPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller.pageController,
          children: [
            BuildPageWelcome(
              color: Colors.white,
              urlImage: 'assets/images/Welcoming.png',
              title: AppString.welcome.tr,
              subtitle: AppString.welcomeToOurApplication.tr,
            ),
            BuildPageBudget(
              color: Colors.white,
              urlImage: 'assets/images/vault.png',
              title: AppString.budget.tr,
              subtitle: AppString.addYourCurrentBudget.tr,
            ),
            BuildPagePassword(
              color: Colors.white,
              urlImage: 'assets/images/password.png',
              title: AppString.password.tr,
              subtitle: AppString.doYouWantToAddPassword.tr,
            ),
          ],
        ),
      ),
      bottomSheet:  Container(
        color: AppColors.white,
        padding: EdgeInsets.symmetric(horizontal: AppConstant.paddingValue),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: (){
              controller.pageController.jumpToPage(2);
            }, child:  Text(AppString.skip.tr, style: TextStyle(color: AppColors.blue,fontWeight: FontWeight.bold),)),
            Center(
              child: SmoothPageIndicator(
                controller: controller.pageController,
                count: 3,
                effect: const WormEffect(
                  spacing: 16,
                  dotColor: AppColors.gray,
                  activeDotColor: AppColors.blue,
                ),
                onDotClicked: (index) => controller.pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                ),
              ),
            ),
            TextButton(onPressed: () async {
              controller.pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
               if(controller.pageController.page == 2 && controller.amount != null && controller.amount!.isNotEmpty && int.parse(controller.amount!) != 0){
                 final id = await db.addCategory(Category(name: AppString.intro.tr, type: OperationType.Income.name));
                 db.addOperations(Operation(type: OperationType.Income.name, amount: int.parse(controller.amount!), date: DateTime.now(), catId: id));
                 Get.offNamed(AppRoutes.home);
               }
              if(controller.pageController.page == 2 && (controller.amount == null || controller.amount.toString().isEmpty || int.parse(controller.amount!) == 0)){
                Get.offNamed(AppRoutes.home);
              }
            }, child:  Text(AppString.next.tr, style: TextStyle(color: AppColors.blue,fontWeight: FontWeight.bold)))
          ],
        ),
      ),
    );
  }
}
