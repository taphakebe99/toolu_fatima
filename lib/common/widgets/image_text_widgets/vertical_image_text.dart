import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../images/my_circular_image.dart';

class MyVerticalImageText extends StatelessWidget {
  const MyVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = MyColors.white,
    this.backgroundColor,
    this.onTap,
    this.isNetworkImage = true,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final bool isNetworkImage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: MySizes.spaceBtwItems),
        child: Column(
          children: [

            MyCircularImage(
              image: image,
              fit: BoxFit.fitWidth,
              padding: MySizes.sm * 1.4,
              isNetworkImage: isNetworkImage,
              backgroundColor: backgroundColor,
              // overlayColor: isDarkMode ? MyColors.light : MyColors.dark,
            ),
            const SizedBox(height: MySizes.spaceBtwItems / 2),
            SizedBox(
              width: 80,
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
