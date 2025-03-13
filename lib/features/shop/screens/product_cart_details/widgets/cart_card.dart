import 'package:flutter/material.dart';

import '../../../../../common/widgets/images/my_rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class CartCard extends StatelessWidget {
  final String title;
  final String quantity;
  final String price;
  final String imagePath;

  const CartCard({
    super.key,
    required this.title,
    required this.quantity,
    required this.price,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: MySizes.sm / 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: MyColors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyRoundedImage(
                imageUrl: imagePath,
                isNetworkImage: true,
                width: 50,
                height: 100,
                fit: BoxFit.fill),
            const SizedBox(width: MySizes.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MySizes.md,
                    ),
                  ),
                  const SizedBox(height: MySizes.sm),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: MySizes.md,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              quantity,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
