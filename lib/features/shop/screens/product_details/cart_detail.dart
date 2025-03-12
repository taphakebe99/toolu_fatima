import 'package:flutter/material.dart';
import 'package:toolu_fatima/features/shop/screens/product_details/widgets/cart_products_details.dart';
import 'package:toolu_fatima/features/shop/screens/product_details/widgets/surrmary_row.dart';

import '../../../../data/pdf/pdf_api.dart';
import '../../../../data/pdf/pdf_invoice_api.dart';
import '../../../../utils/constants/sizes.dart';
import '../../models/order_model.dart';

class CartDetailScreen extends StatelessWidget {
  final OrderModel order;

  const CartDetailScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détail du panier'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(MySizes.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CartProductsDetails(order: order),
            const Divider(),
            Column(
              children: [
                SummaryRow(
                  title: "Sous-total",
                  value: Text(
                    "${order.totalAmount.toStringAsFixed(0)} FCFA",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SummaryRow(
                  title: "Votre ticket de caisse",
                  value: TextButton(
                    onPressed: () async {
                      final pdfFile = await PdfInvoiceApi.generate(order);

                      PdfApi.openFile(pdfFile);
                    },
                    child: const Icon(
                      Icons.remove_red_eye_outlined,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: MySizes.sm * 3),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
