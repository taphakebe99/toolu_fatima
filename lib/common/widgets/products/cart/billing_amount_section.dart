import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../features/shop/controllers/product/checkout_controller.dart';
import '../../../../utils/constants/sizes.dart';

class MyBillingAmountSection extends StatelessWidget {
  const MyBillingAmountSection({super.key, required this.subTotal});

  final double subTotal;

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    return Column(
      children: [
        /// -- Sub Total
        Row(
          children: [
            Expanded(
                child: Text('Sous-total',
                    style: Theme.of(context).textTheme.bodyMedium)),
            Text('${subTotal.toStringAsFixed(2)} CFA',
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: MySizes.spaceBtwItems / 2),

        /// -- Shipping Fee
        Row(
          children: [
            Expanded(
              child: Text(
                'Frais de livraison',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Obx(
              () => Text(
                '${controller.isShippingFree(subTotal) ? 'Gratuit' : (controller.getShippingCost(subTotal)).toStringAsFixed(2)} CFA',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ],
        ),
        const SizedBox(height: MySizes.spaceBtwItems / 2),

        /// -- Tax Fee
        Row(
          children: [
            Expanded(
              child: Text(
                'Frais de taxe',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Obx(
              () => Text(
                '${controller.getTaxAmount(subTotal).toStringAsFixed(2)} CFA',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ],
        ),
        const SizedBox(height: MySizes.spaceBtwItems),

        /// -- Order Total
        Row(
          children: [
            Expanded(
              child: Text(
                'Total de la commande',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Text(
              '${controller.getTotal(subTotal).toStringAsFixed(2)} CFA',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ],
    );
  }
}
