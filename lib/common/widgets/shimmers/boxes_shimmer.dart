import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';
import 'shimmer.dart';

class MyBoxesShimmer extends StatelessWidget {
  const MyBoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(child: MyShimmerEffect(width: 150, height: 110)),
            SizedBox(width: MySizes.spaceBtwItems),
            Expanded(child: MyShimmerEffect(width: 150, height: 110)),
            SizedBox(width: MySizes.spaceBtwItems),
            Expanded(child: MyShimmerEffect(width: 150, height: 110)),
          ],
        )
      ],
    );
  }
}
