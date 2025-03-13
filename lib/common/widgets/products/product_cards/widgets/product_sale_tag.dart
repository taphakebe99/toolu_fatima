import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../custom_shapes/containers/rounded_container.dart';

class ProductSaleTagWidget extends StatelessWidget {
  const ProductSaleTagWidget({
    super.key,
    required this.salePercentage,
  });

  final String? salePercentage;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 12,
      child: MyRoundedContainer(
        radius: MySizes.sm,
        backgroundColor: MyColors.secondary.withValues(alpha: 0.8),
        padding: const EdgeInsets.symmetric(
            horizontal: MySizes.sm, vertical: MySizes.xs),
        child: Text('$salePercentage%',
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .apply(color: MyColors.black)),
      ),
    );
  }
}
