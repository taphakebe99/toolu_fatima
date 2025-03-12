import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/onboarding/onboarding_controller.dart';

/// A floating circular button for navigating to the next onboarding page.
class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = MyHelperFunctions.isDarkMode(context);

    return Positioned(
      right: MySizes.defaultSpace,
      bottom: MyDeviceUtility.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () => OnBoardingController.instance.nextPage(),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(16),
          backgroundColor: isDarkMode ? MyColors.primary : Colors.black,
          elevation: 5,
        ),
        child: const Icon(
          Icons.arrow_forward_ios_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
