import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/product/product_controller.dart';
import '../../../models/order_model.dart';
import 'cart_card.dart';

class CartProductsDetails extends StatelessWidget {
  const CartProductsDetails({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());

    return Expanded(
      child: ListView.builder(
        itemCount: order.items.length,
        itemBuilder: (context, index) {
          final orderItem = order.items[index];

          return FutureBuilder(
            future: productController.fetchProductById(orderItem.productId),
            builder: (context, productSnapshot) {
              if (productSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (productSnapshot.hasError || productSnapshot.data == null) {
                return const Text("Produit non disponible",
                    style: TextStyle(color: Colors.red));
              }

              return Padding(
                padding: const EdgeInsets.all(MySizes.sm / 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CartCard(
                      title: orderItem.title,
                      quantity:
                          '${orderItem.quantity}${orderItem.selectedVariation != null ? " (${orderItem.selectedVariation!.entries.map((e) => "${e.key}: ${e.value}").join(", ")})" : ""}',
                      price: '${orderItem.price.toStringAsFixed(0)} FCFA',
                      imagePath: orderItem.image!,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
