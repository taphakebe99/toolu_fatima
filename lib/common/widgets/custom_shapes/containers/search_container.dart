import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';

class MySearchContainer extends StatelessWidget {
  const MySearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: MySizes.defaultSpace),
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = MyHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          width: MyDeviceUtility.getScreenWidth(context),
          padding: const EdgeInsets.all(MySizes.md),
          decoration: BoxDecoration(
            color: showBackground
                ? isDarkMode
                    ? MyColors.dark
                    : MyColors.light
                : Colors.transparent,
            borderRadius: BorderRadius.circular(MySizes.cardRadiusLg),
            border: showBorder ? Border.all(color: MyColors.grey) : null,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isDarkMode ? MyColors.darkerGrey : MyColors.grey,
              ),
              const SizedBox(width: MySizes.spaceBtwItems),
              Text(text, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
