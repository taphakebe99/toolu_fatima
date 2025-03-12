import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../controllers/onboarding/onboarding_controller.dart';

/// A widget for adding a "Skip" button at the top of the onboarding screen.
class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MyDeviceUtility.getAppBarHeight(),
      right: MySizes.defaultSpace,
      child: TextButton(
        onPressed: () => OnBoardingController.instance.skipPage(),
        style: TextButton.styleFrom(
          foregroundColor: Theme.of(context).primaryColor,
          textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        child: const Text('Passer', style: TextStyle(color: MyColors.black),),
      ),
    );
  }
}
