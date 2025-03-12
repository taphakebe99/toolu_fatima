import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../models/order_model.dart';
import '../../product_details/cart_detail.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    // Formatter la date
    String formattedDate =
        DateFormat("dd/MM/yyyy · HH:mm").format(order.orderDate);

    // Formater le statut en chaîne
    String statusText;
    if (order.status == OrderStatus.delivered) {
      statusText = "Livrée";
    } else if (order.status == OrderStatus.cancelled) {
      statusText = "Annulée";
    } else {
      statusText = "En cours";
    }

    return Card(
      //margin: const EdgeInsets.symmetric(vertical: MySizes.sm),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(MySizes.sm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ligne d'en-tête : nombre de produits achetés et date/heure
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${order.items.length} produits achetés",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  formattedDate,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: MySizes.spaceBtwSections),
            // Ligne d'informations : montant total, statut et bouton "Détails"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${order.totalAmount.toStringAsFixed(0)} FCFA",
                  style: const TextStyle(color: Colors.black),
                ),
                Text(
                  statusText,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Get.to(() => CartDetailScreen(
                        order: order,
                      )),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.grey,
                    side: BorderSide(color: MyColors.grey, width: 2),
                  ),
                  child: const Text(
                    "Détails",
                    style: TextStyle(color: MyColors.black, fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
