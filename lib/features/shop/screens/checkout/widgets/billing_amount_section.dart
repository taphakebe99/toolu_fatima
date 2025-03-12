/*import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';

class BillingAmountSection extends StatelessWidget {
  const BillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// SubTotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Sous-total', style: Theme.of(context).textTheme.bodyMedium),
            Text('1199 CFA', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: MySizes.spaceBtwItems / 2),

        /// Shopping fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Frais de livraison',
                style: Theme.of(context).textTheme.bodyMedium),
            Text('0.0', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: MySizes.spaceBtwItems / 2),

        /// Order total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total de la commande',
                style: Theme.of(context).textTheme.bodyMedium),
            Text('6000 CFA', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(height: MySizes.spaceBtwItems / 2),
      ],
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/product/checkout_controller.dart';

class BillingAmountSection extends StatelessWidget {
  const BillingAmountSection({super.key, required this.subTotal});

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
            Text('${subTotal.toStringAsFixed(0)} FCFA',
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: MySizes.spaceBtwItems / 2),

        /// -- Shipping Fee
        Row(
          children: [
            Expanded(
                child: Text('Frais de livraison',
                    style: Theme.of(context).textTheme.bodyMedium)),
            Obx(
              () => Text(
                '${controller.isShippingFree(subTotal) ? 'Free' : (controller.getShippingCost(subTotal)).toStringAsFixed(0)} FCFA',
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
                child:
                    Text('Tax', style: Theme.of(context).textTheme.bodyMedium)),
            Obx(
              () => Text(
                '${controller.getTaxAmount(subTotal).toStringAsFixed(0)} FCFA',
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
                child: Text('Total de la commande',
                    style: Theme.of(context).textTheme.titleMedium)),
            Text(
              '${controller.getTotal(subTotal).toStringAsFixed(0)} FCFA',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ],
    );
  }
}
