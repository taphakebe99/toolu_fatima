import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../models/order_model.dart';
import 'order_card.dart';

class MyOrderTab extends StatelessWidget {
  const MyOrderTab({super.key, required this.orders});

  final List<OrderModel> orders;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MySizes.sm),
      child: orders.isEmpty
          ? Center(
              // Afficher un message si la liste est vide
              child: Text(
                "Aucune donnée trouvée",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: orders.length,
              itemBuilder: (_, index) => Padding(
                padding: const EdgeInsets.only(bottom: MySizes.sm / 3),
                child: OrderCard(order: orders[index]),
              ),
            ),
    );
  }
}
