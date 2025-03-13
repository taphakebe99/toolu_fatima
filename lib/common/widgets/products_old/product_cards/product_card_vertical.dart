/*import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../features/shop/controllers/unity_controller.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../features/shop/screens/product_cart_details/product_detail.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../styles/shadow_style.dart';
import '../../custom_shapes/containers/rounded_container.dart';
import '../../images/my_rounded_image.dart';
import '../../texts/product_price_text.dart';
import '../../texts/product_title_text.dart';

class MyProductCardVertical extends StatelessWidget {
  const MyProductCardVertical({
    super.key,
    required this.product,
    this.isNetworkImage = true,
  });

  final ProductModel product;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = MyHelperFunctions.isDarkMode(context);
    final UnityController unitController = Get.put(UnityController());

    return GestureDetector(
      onTap: () => Get.to(
        () => ProductDetailScreen(
          product: product,
        ),
      ),
      child: SizedBox(
        width: 200,
        height: 350,
        child: Container(
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            boxShadow: [MyShadowStyle.verticalProductShadow],
            borderRadius: BorderRadius.circular(MySizes.productImageRadius),
            color: isDarkMode ? MyColors.darkerGrey : MyColors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyRoundedContainer(
                height: 180,
                padding: const EdgeInsets.all(MySizes.md),
                backgroundColor: isDarkMode ? MyColors.dark : MyColors.light,
                child: Stack(
                  children: [
                    /// Image du produit
                    MyRoundedImage(
                      imageUrl: product.image,
                      applyImageRadius: true,
                      isNetworkImage: isNetworkImage,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: MySizes.spaceBtwItems / 2),

              /// Détails
              Padding(
                padding: const EdgeInsets.only(left: MySizes.sm),
                child: MyProductTitleText(
                  title: product.title,
                ),
              ),
              const SizedBox(height: MySizes.spaceBtwItems),

              /// Display unit asynchronously using FutureBuilder
              FutureBuilder(
                future:
                    unitController.fetchUnitById(product.unityId.toString()),
                builder: (context, AsyncSnapshot unitySnapshot) {
                  if (unitySnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (unitySnapshot.hasError || unitySnapshot.data == null) {
                    return const Text(
                      "Unité non disponible",
                      style: TextStyle(color: Colors.red),
                    );
                  }

                  final unity = unitySnapshot.data;
                  return MyRoundedContainer(
                    padding: const EdgeInsets.symmetric(horizontal: MySizes.sm),
                    child: MyProductPriceText(
                      price: product.price.toStringAsFixed(0),
                      unity: unity.unity, // Correct usage
                      isLarge: false,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
