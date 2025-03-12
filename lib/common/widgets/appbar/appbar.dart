import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/device/device_utility.dart';
import '../../../utils/helpers/helper_functions.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    this.title,
    this.showBackArrow = false,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
    this.arrowBackOnPressed,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final VoidCallback? arrowBackOnPressed;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = MyHelperFunctions.isDarkMode(context);

    return Padding(
      padding: EdgeInsets.zero,
      child: AppBar(
        backgroundColor: MyColors.primary,
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
                onPressed: arrowBackOnPressed ?? () => Get.back(),
                icon: const Icon(Iconsax.arrow_left),
                color: isDarkMode ? Colors.white : MyColors.dark,
              )
            : leadingIcon != null
                ? IconButton(
                    onPressed: leadingOnPressed,
                    icon: Icon(leadingIcon),
                  )
                : null,
        title: title,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(MyDeviceUtility.getAppBarHeight());
}
