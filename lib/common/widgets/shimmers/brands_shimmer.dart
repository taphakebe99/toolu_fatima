import 'package:flutter/material.dart';

import '../layouts/grid_layout.dart';
import 'shimmer.dart';

class MyBrandsShimmer extends StatelessWidget {
  const MyBrandsShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return MyGridLayout(
      mainAxisExtent: 80,
      itemCount: itemCount,
      itemBuilder: (_, __) => const MyShimmerEffect(width: 300, height: 80),
    );
  }
}
