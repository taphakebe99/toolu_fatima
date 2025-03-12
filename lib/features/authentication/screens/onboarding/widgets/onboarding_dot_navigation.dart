import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/onboarding/onboarding_controller.dart';

/// A widget that displays a SmoothPageIndicator for onboarding screens, positioned near the bottom.
class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final isDarkMode = MyHelperFunctions.isDarkMode(context);
    return Positioned(
      bottom: MyDeviceUtility.getBottomNavigationBarHeight() + 25,
      left: MySizes.defaultSpace,
      child: SmoothPageIndicator(
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        count: 2,
        effect: ExpandingDotsEffect(
          activeDotColor: isDarkMode ? MyColors.light : MyColors.dark,
          dotHeight: 6,
        ),
      ),
    );
  }
}
