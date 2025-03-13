import 'package:flutter/cupertino.dart';

import '../../../../../utils/constants/sizes.dart';

class SummaryRow extends StatelessWidget {
  final String title;
  final Widget value;

  const SummaryRow({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: MySizes.spaceBtwSections),
          value,
        ],
      ),
    );
  }
}
