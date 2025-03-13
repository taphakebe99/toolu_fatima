import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolu_fatima/features/shop/screens/receipt/widgets/receipt_item_widget.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/product/product_controller.dart';
import '../../models/order_model.dart';

class ReceiptScreen extends StatelessWidget {
  const ReceiptScreen({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Ticket de caisse",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: MySizes.spaceBtwSections),

            // Liste des articles de la commande
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: order.items.length,
              itemBuilder: (_, index) {
                final orderItem = order.items[index];

                return FutureBuilder(
                  future:
                      productController.fetchProductById(orderItem.productId),
                  builder: (context, productSnapshot) {
                    if (productSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (productSnapshot.hasError ||
                        productSnapshot.data == null) {
                      return const Text(
                        "Produit non disponible",
                        style: TextStyle(color: Colors.red),
                      );
                    }

                    return ReceiptItem(
                      label: "${orderItem.quantity} ${orderItem.title}",
                      value: "${orderItem.price.toStringAsFixed(0)} FCFA",
                    );
                  },
                );
              },
            ),

            const Divider(),

            // Sous-total et Livraison
            ReceiptItem(
              label: "Sous-total",
              value:
                  "${(order.totalAmount - order.shippingCost).toStringAsFixed(0)} FCFA",
              isBold: true,
            ),
            ReceiptItem(
              label: "Livraison",
              value: "${order.shippingCost.toStringAsFixed(0)} FCFA",
            ),
            ReceiptItem(
              label: "Total",
              value: "${order.totalAmount.toStringAsFixed(0)} FCFA",
              isBold: true,
            ),

            const SizedBox(height: MySizes.spaceBtwSections),

            // Méthode de paiement
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Méthode de paiement",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                order.paymentMethod.isNotEmpty
                    ? Image.asset(
                        order.paymentMethod,
                        width: 40,
                        height: 40,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.payment, color: MyColors.primary),
                      )
                    : const Text("Non spécifiée"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
