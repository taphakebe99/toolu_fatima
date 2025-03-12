import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../../common/widgets/shimmers/shimmer.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../personalization/controllers/settings_controller.dart';
import '../../../../personalization/controllers/user_controller.dart';
import '../../../../personalization/screens/profile/profile.dart';

class MyHomeAppBar extends StatelessWidget {
  const MyHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Just to create instance and fetch values
    Get.put(SettingsController());
    final userController = Get.put(UserController());

    return MyAppBar(
      title: GestureDetector(
        onTap: () => Get.to(() => const ProfileScreen()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: MySizes.sm),
            Text(
              MyTexts.homeAppBarTitle,
              style: Theme.of(context).textTheme.labelMedium!.apply(
                    color: MyColors.darkerGrey,
                  ),
            ),
            const SizedBox(height: MySizes.spaceBtwItems),
            Obx(
              () {
                // Check if user Profile is still loading
                if (userController.profileLoading.value) {
                  // Display a shimmer loader while user profile is being loaded
                  return const MyShimmerEffect(width: 80, height: 15);
                } else {
                  // Check if there are no record found
                  if (userController.user.value.id.isEmpty) {
                    // Display a message when no data is found
                    return Text(
                      'Anonyme',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .apply(color: MyColors.black),
                    );
                  } else {
                    // Display User Name
                    return Text(
                      userController.user.value.fullName,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .apply(color: MyColors.black),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: MySizes.sm),
          child: MyCartCounterIcon(
            iconColor: MyColors.black,
            counterBgColor: MyColors.black,
            counterTextColor: MyColors.white,
          ),
        )
      ],
    );
  }
}
