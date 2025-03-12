import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';

/// A widget that displays social media login buttons (Google and Facebook).
///
/// This widget aligns the buttons horizontally and applies consistent styling
/// for a cohesive social sign-in section.
class MySocialButtons extends StatelessWidget {
  const MySocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center, // Centers buttons horizontally
      children: [
        // Google Button Container
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100), // Circular button shape
            border: Border.all(
                color: MyColors.grey), // Grey border around the button
          ),
          child: IconButton(
            onPressed: () {}, // Empty callback, replace as needed
            icon: const Image(
              width: MySizes.iconMd, // Icon size specified in MySizes
              height: MySizes.iconMd,
              image:
                  AssetImage(MyImages.google), // Google icon image from assets
            ),
          ),
        ),
        const SizedBox(
            width: MySizes.spaceBtwItems), // Horizontal spacing between buttons

        // Facebook Button Container
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100), // Circular button shape
            border: Border.all(
                color: MyColors.grey), // Grey border around the button
          ),
          child: IconButton(
            onPressed: () {}, // Empty callback, replace as needed
            icon: const Image(
              width: MySizes.iconMd, // Icon size specified in MySizes
              height: MySizes.iconMd,
              image: AssetImage(
                  MyImages.facebook), // Facebook icon image from assets
            ),
          ),
        ),
      ],
    );
  }
}
