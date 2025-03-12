import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';
import 'shimmer.dart';

class MyHorizontalProductShimmer extends StatelessWidget {
  const MyHorizontalProductShimmer({
    super.key,
    this.itemCount = 4,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: MySizes.spaceBtwSections),
      height: 120,
      child: ListView.separated(
        itemCount: itemCount,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) =>
            const SizedBox(width: MySizes.spaceBtwItems),
        itemBuilder: (_, __) => const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Image
            MyShimmerEffect(width: 120, height: 120),
            SizedBox(width: MySizes.spaceBtwItems),

            /// Text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: MySizes.spaceBtwItems / 2),
                MyShimmerEffect(width: 160, height: 15),
                SizedBox(height: MySizes.spaceBtwItems / 2),
                MyShimmerEffect(width: 110, height: 15),
                SizedBox(height: MySizes.spaceBtwItems / 2),
                MyShimmerEffect(width: 80, height: 15),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
