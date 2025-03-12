import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';
import 'category_title_text.dart';

class MyCategoryTitleWithVerifiedIcon extends StatelessWidget {
  const MyCategoryTitleWithVerifiedIcon({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor,
    this.iconColor = MyColors.primary,
    this.textAlign = TextAlign.center,
    this.brandTextSizes = TextSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign textAlign;
  final TextSizes brandTextSizes;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: MyCategoryTitleText(
            title: title,
            color: textColor,
            textAlign: textAlign,
            brandTextSizes: brandTextSizes,
            maxLines: maxLines,
          ),
        ),
        const SizedBox(width: MySizes.xs),
        Icon(
          Iconsax.verify5,
          color: iconColor,
          size: MySizes.iconXs,
        ),
      ],
    );
  }
}
