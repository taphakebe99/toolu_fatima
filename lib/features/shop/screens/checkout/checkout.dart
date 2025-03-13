import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolu_fatima/features/shop/screens/checkout/widgets/billing_amount_section.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../authentication/screens/signup/complete_profile_screen.dart';
import '../../../personalization/controllers/user_controller.dart';
import '../../controllers/product/cart_controller.dart';
import '../../controllers/product/checkout_controller.dart';
import '../../controllers/product/order_controller.dart';
import '../cart/widgets/cart_items.dart';
import 'widgets/billing_address_section.dart';
import 'widgets/billing_payment_section.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final checkoutController = Get.put(CheckoutController());
    final userController = Get.put(UserController());
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    final dark = MyHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: const MyAppBar(
          title: Text('Révision de la commande'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MySizes.defaultSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// -- Items in Cart
              const MyCartItems(showAddRemoveButtons: false),
              const SizedBox(height: MySizes.spaceBtwSections),

              /// -- Billing Section
              MyRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(MySizes.md),
                backgroundColor: dark ? MyColors.black : MyColors.white,
                child: Column(
                  children: [
                    /// Pricing
                    BillingAmountSection(subTotal: subTotal),
                    const SizedBox(height: MySizes.spaceBtwItems),

                    /// Divider
                    const Divider(),
                    const SizedBox(height: MySizes.spaceBtwItems),

                    /// Payment Methods
                    const BillingPaymentSection(),
                    const SizedBox(height: MySizes.spaceBtwSections),

                    /// Address
                    const AddressSection(),
                    const SizedBox(height: MySizes.spaceBtwItems),

                    /// Divider
                    const Divider(),
                    const SizedBox(height: MySizes.spaceBtwItems),
                  ],
                ),
              ),
              const SizedBox(height: MySizes.spaceBtwSections),
            ],
          ),
        ),
      ),

      /// -- Checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(MySizes.defaultSpace),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(MyColors.primary),
            ),
            onPressed: subTotal > 0
                ? () {
                    // Vérifier si l'utilisateur est anonyme (par exemple, si son email est vide)
                    final user = userController.user.value;
                    if (user.fullName.isEmpty && user.phoneNumber.isEmpty) {
                      // Rediriger vers l'écran de complétion de profil
                      Get.to(() => const CompleteProfileScreen());
                    } else {
                      // Traiter la commande normalement
                      orderController.processOrder(subTotal);
                    }
                  }
                : () => MyLoaders.warningSnackBar(
                      title: 'Panier vide',
                      message:
                          'Ajoutez des articles dans le panier pour continuer.',
                    ),
            child: Text(
              'Paiement ${checkoutController.getTotal(subTotal).toStringAsFixed(0)} FCFA',
              style: const TextStyle(color: MyColors.black),
            ),
          ),
        ),
      ),
    );
  }
}
