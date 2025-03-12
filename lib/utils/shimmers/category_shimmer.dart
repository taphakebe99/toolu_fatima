import 'package:flutter/material.dart';

import '../../common/widgets/shimmers/shimmer.dart';
import '../constants/sizes.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({
    super.key,
    this.itemCount = 6,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
          itemBuilder: (_, __) {
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyShimmerEffect(
                  width: 55,
                  height: 55,
                  radius: 55,
                ),
                SizedBox(height: MySizes.spaceBtwItems / 2),
                MyShimmerEffect(width: 55, height: 8),
              ],
            );
          },
          separatorBuilder: (_, __) =>
              const SizedBox(width: MySizes.spaceBtwItems),
          itemCount: itemCount),
    );
  }
}
