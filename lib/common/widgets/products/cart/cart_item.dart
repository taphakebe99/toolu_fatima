import 'package:flutter/material.dart';

import '../../../../features/shop/models/cart_item_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../images/my_rounded_image.dart';
import '../../texts/product_title_text.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.item,
  });

  final CartItemModel item;

  @override
  Widget build(BuildContext context) {
    final dark = MyHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        /// 1 - Image
        MyRoundedImage(
          width: 60,
          height: 60,
          isNetworkImage: true,
          imageUrl: item.image ?? '',
          padding: const EdgeInsets.all(MySizes.sm),
          backgroundColor: dark ? MyColors.darkerGrey : MyColors.light,
        ),
        const SizedBox(width: MySizes.spaceBtwItems),

        /// 2 - Title, Price, & Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Brand and Title
              /* TBrandTitleWithVerifiedIcon(title: item.brandName ?? ''),*/
              Flexible(
                  child: MyProductTitleText(title: item.title, maxLines: 1)),

              /// Attributes
              Text.rich(
                TextSpan(
                  children: ({})
                      .entries
                      .map(
                        (e) => TextSpan(
                          children: [
                            TextSpan(
                              text: ' ${e.key} ',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            TextSpan(
                              text: '${e.value} ',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

