/*import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/loaders/animation_loader.dart';
import '../../../../home_menu.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/product/cart_controller.dart';
import '../checkout/checkout.dart';
import 'widgets/cart_items.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    final cartItems = controller.cartItems;
    return Scaffold(
      /// -- AppBar
      appBar: MyAppBar(
          showBackArrow: true,
          title:
              Text('Panier', style: Theme.of(context).textTheme.headlineSmall)),
      body: Obx(() {
        /// Widget lorsque le panier est vide
        final emptyWidget = MyAnimationLoaderWidget(
          text: 'Oups ! Votre panier est vide.',
          animation: MyImages.cartAnimation,
          showAction: true,
          actionText: 'Ajoutons des articles',
          onActionPressed: () => Get.off(() => const HomeMenu()),
        );

        /// Articles du panier
        return cartItems.isEmpty
            ? emptyWidget
            : const SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(MySizes.defaultSpace),

                  /// -- Articles dans le panier
                  child: CartItems(),
                ),
              );
      }),

      /// -- Bouton de validation de commande
      bottomNavigationBar: Obx(
        () {
          return cartItems.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(MySizes.defaultSpace),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(MyColors.primary),
                      ),
                      onPressed: () => Get.to(() => const CheckoutScreen()),
                      child: Obx(
                        () => Text(
                          'Valider la commande : ${controller.totalCartPrice.value.toStringAsFixed(0)} FCFA',
                          style: TextStyle(color: MyColors.black,),
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox();
        },
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/loaders/animation_loader.dart';
import '../../../../home_menu.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/product/cart_controller.dart';
import '../checkout/checkout.dart';
import 'widgets/cart_items.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final cartItems = controller.cartItems;
    return Scaffold(
      /// -- AppBar
      appBar: MyAppBar(
          showBackArrow: true,
          title:
              Text('Panier', style: Theme.of(context).textTheme.headlineSmall)),
      body: Obx(() {
        /// Nothing Found Widget
        final emptyWidget = MyAnimationLoaderWidget(
          text: 'Oups ! Le panier est VIDE.',
          animation: MyImages.cartAnimation,
          showAction: true,
          actionText: 'Remplissons-le',
          onActionPressed: () => Get.off(() => const HomeMenu()),
        );

        /// Cart Items
        return cartItems.isEmpty
            ? emptyWidget
            : const SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(MySizes.defaultSpace),

                  /// -- Items in Cart
                  child: MyCartItems(),
                ),
              );
      }),

      /// -- Checkout Button
      bottomNavigationBar: Obx(
        () {
          return cartItems.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(MySizes.defaultSpace),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(MyColors.primary),
                      ),
                      onPressed: () => Get.to(() => const CheckoutScreen()),
                      child: Obx(
                        () => Text(
                          'Passer à la caisse ${controller.totalCartPrice.value.toStringAsFixed(0)} FCFA',
                          style: TextStyle(
                            color: MyColors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox();
        },
      ),
    );
  }
}
