import 'package:flutter/material.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../common/widgets/texts/product_title_text.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/product/product_controller.dart';
import '../../../models/product_model.dart';

class MyProductMetaData extends StatelessWidget {
  const MyProductMetaData({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage = ProductController.instance
        .calculateSalePercentage(product.price, product.salePrice);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale Price
        Row(
          children: [
            /// -- Sale Tag
            if (salePercentage != null)
              Row(
                children: [
                  MyRoundedContainer(
                    backgroundColor: MyColors.secondary,
                    radius: MySizes.sm,
                    padding: const EdgeInsets.symmetric(
                        horizontal: MySizes.sm, vertical: MySizes.xs),
                    child: Text('$salePercentage%',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: MyColors.black)),
                  ),
                  const SizedBox(width: MySizes.spaceBtwItems)
                ],
              ),

            // Actual Price if sale price not null.
            if ((product.productVariations == null ||
                    product.productVariations!.isEmpty) &&
                product.salePrice > 0.0)
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${product.price.toStringAsFixed(2)}F',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .apply(decoration: TextDecoration.lineThrough),
                    ),
                  ],
                ),
              ),

            // Price, Show sale price as main price if sale exist.
            Expanded(
              child: MyProductPriceText(
                  price: controller.getProductPrice(product), isLarge: true),
            ),
          ],
        ),
        const SizedBox(height: MySizes.spaceBtwItems / 1.5),
        MyProductTitleText(title: product.title),
        const SizedBox(height: MySizes.spaceBtwItems / 1.5),
        Row(
          children: [
            const MyProductTitleText(title: 'Stock : ', smallSize: true),
            Text('En stock', style: Theme.of(context).textTheme.titleMedium),
            //Text(controller.getProductStockStatus(product), style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(height: MySizes.spaceBtwItems / 2),
      ],
    );
  }
}
