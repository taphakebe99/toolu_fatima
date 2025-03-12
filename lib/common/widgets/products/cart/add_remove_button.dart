import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../icons/my_circular_icon.dart';

class MyProductQuantityWithAddRemoveButton extends StatelessWidget {
  const MyProductQuantityWithAddRemoveButton({
    super.key,
    required this.add,
    this.width = 40,
    this.height = 40,
    this.iconSize,
    required this.remove,
    required this.quantity,
    this.addBackgroundColor = MyColors.black,
    this.removeBackgroundColor = MyColors.darkGrey,
    this.addForegroundColor = MyColors.white,
    this.removeForegroundColor = MyColors.white,
  });

  final VoidCallback? add, remove;
  final int quantity;
  final double width, height;
  final double? iconSize;
  final Color addBackgroundColor, removeBackgroundColor;
  final Color addForegroundColor, removeForegroundColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MyCircularIcon(
          icon: Iconsax.minus,
          onPressed: remove,
          width: width,
          height: height,
          size: iconSize,
          color: removeForegroundColor,
          backgroundColor: removeBackgroundColor,
        ),
        const SizedBox(width: MySizes.spaceBtwItems),
        Text(quantity.toString(),
            style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(width: MySizes.spaceBtwItems),
        MyCircularIcon(
          icon: Iconsax.add,
          onPressed: add,
          width: width,
          height: height,
          size: iconSize,
          color: addForegroundColor,
          backgroundColor: addBackgroundColor,
        ),
      ],
    );
  }
}

