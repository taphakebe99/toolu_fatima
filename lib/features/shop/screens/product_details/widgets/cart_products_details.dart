import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/product/product_controller.dart';
import '../../../controllers/unity_controller.dart';
import '../../../models/order_model.dart';
import 'cart_card.dart';

class CartProductsDetails extends StatelessWidget {
  const CartProductsDetails({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final unitController = Get.put(UnityController());
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

              final product = productSnapshot.data;

              return FutureBuilder(
                future:
                    unitController.fetchUnitById(product!.unityId.toString()),
                builder: (context, unitSnapshot) {
                  if (unitSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (unitSnapshot.hasError || unitSnapshot.data == null) {
                    return const Text("Unité non disponible",
                        style: TextStyle(color: Colors.red));
                  }

                  final unit = unitSnapshot.data;

                  return Padding(
                    padding: const EdgeInsets.all(MySizes.sm / 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CartCard(
                          title: orderItem.title,
                          instruction: orderItem.instruction ?? '',
                          quantity: '${orderItem.quantity} / ${unit?.unity}',
                          price: '${orderItem.price.toStringAsFixed(0)} FCFA',
                          imagePath: orderItem.image!,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
