import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';
import '../layouts/grid_layout.dart';
import 'shimmer.dart';

class MyVerticalProductShimmer extends StatelessWidget {
  const MyVerticalProductShimmer({
    super.key,
    this.itemCount = 4,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return MyGridLayout(
      itemCount: itemCount,
      itemBuilder: (_, __) => const SizedBox(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image
            MyShimmerEffect(width: 180, height: 180),
            SizedBox(height: MySizes.spaceBtwItems),

            /// Text
            MyShimmerEffect(width: 160, height: 15),
            SizedBox(height: MySizes.spaceBtwItems / 2),
            MyShimmerEffect(width: 110, height: 15),
          ],
        ),
      ),
    );
  }
}
