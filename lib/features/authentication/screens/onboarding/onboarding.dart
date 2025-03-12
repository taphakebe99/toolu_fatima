import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolu_fatima/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:toolu_fatima/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:toolu_fatima/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:toolu_fatima/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../controllers/onboarding/onboarding_controller.dart';

/// The main onboarding screen that displays a series of pages with images,
/// titles, and descriptions, along with navigation controls.
class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the onboarding controller.
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      backgroundColor: MyColors.primary,
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: MyImages.onBoardingImage1,
                title: MyTexts.onBoardingTitle1,
                subTitle: MyTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: MyImages.onBoardingImage2,
                title: MyTexts.onBoardingTitle1,
                subTitle: MyTexts.onBoardingSubTitle2,
              ),
            ],
          ),
          const OnBoardingSkip(),
          const OnBoardingDotNavigation(),
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}
