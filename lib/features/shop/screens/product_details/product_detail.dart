import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:readmore/readmore.dart';
import 'package:toolu_fatima/features/shop/screens/product_details/widgets/add_instructions_widget.dart';
import 'package:toolu_fatima/features/shop/screens/product_details/widgets/add_unity_widget.dart';

import '../../../../common/widgets/button/my_button_widget.dart';
import '../../../../common/widgets/images/my_rounded_image.dart';
import '../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../common/widgets/texts/product_price_text.dart';
import '../../../../common/widgets/texts/product_title_text.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../controllers/product/cart_controller.dart';
import '../../controllers/unity_controller.dart';
import '../../models/product_model.dart';
import '../checkout/checkout.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final unitController = Get.put(UnityController());

    controller.updateAlreadyAddedProductCount(product);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(MySizes.defaultSpace),
        child: Obx(
          () => MyButton(
            onPressed: controller.productQuantityInCart.value < 1
                ? null
                : () => controller.addToCart(product),
            title: 'Ajouter au panier',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Image du produit
            MyRoundedImage(
              imageUrl: product.image,
              height: 200,
              isNetworkImage: true,
            ),

            /// Détails du produit
            Padding(
              padding: const EdgeInsets.only(
                right: MySizes.defaultSpace,
                left: MySizes.defaultSpace,
                bottom: MySizes.defaultSpace,
              ),
              child: Column(
                children: [
                  MyProductTitleText(title: product.title),

                  /// Récupération de l'unité de mesure
                  FutureBuilder(
                    future: unitController
                        .fetchUnitById(product.unityId.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError ||
                          !snapshot.hasData ||
                          snapshot.data == null) {
                        return const Center(child: Text("Unité indisponible"));
                      }

                      final unity = snapshot.data!;

                      return Column(
                        children: [
                          /// Prix avec unité
                          MyProductPriceText(
                            price: product.price.toStringAsFixed(0),
                            isLarge: true,
                            unity: unity.unity
                          ),

                          const SizedBox(height: MySizes.spaceBtwSections),

                          /// Description
                          ReadMoreText(
                            product.description ??
                                'Aucune description disponible',
                            trimLines: 2,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Plus',
                            trimExpandedText: 'Moins',
                            moreStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w800),
                            lessStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w800),
                          ),

                          const Divider(),
                          const SizedBox(height: MySizes.spaceBtwItems),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// Ajouter / Enlever Quantité
                              Obx(
                                () => MyProductQuantityWithAddRemoveButton(
                                  quantity:
                                      controller.productQuantityInCart.value,
                                  add: () => controller
                                      .productQuantityInCart.value += 1,
                                  remove: () {
                                    if (controller.productQuantityInCart.value >
                                        0) {
                                      controller.productQuantityInCart.value -=
                                          1;
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: MySizes.spaceBtwItems),

                              /// Ajouter une unité
                              AddUnity(unit: unity.unity ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: MySizes.spaceBtwSections),
                  AddInstruction(),
                  const SizedBox(height: MySizes.spaceBtwSections),

                  /// Bouton "Passer à la caisse"
                  SizedBox(
                    width: MyDeviceUtility.getScreenWidth(context),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(MyColors.primary),
                      ),
                      child: const Text(
                        'Passer à la caisse',
                        style: TextStyle(color: MyColors.black),
                      ),
                      onPressed: () => Get.to(() => const CheckoutScreen()),
                    ),
                  ),
                  const SizedBox(height: MySizes.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
