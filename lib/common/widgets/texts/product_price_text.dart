import 'package:flutter/material.dart';

class MyProductPriceText extends StatelessWidget {
  const MyProductPriceText({
    super.key,
    required this.price,
    this.isLarge = false,
    this.currencySign = ' FCFA',
    this.maxLines = 1,
    this.lineThrough = false,
    this.unity = 'pièce',
  });

  final String price, currencySign, unity;
  final bool isLarge;
  final int maxLines;
  final bool lineThrough;

  @override
  Widget build(BuildContext context) {
    return Text(
      currencySign.contains('\$')
          ? '$currencySign$price/$unity'
          : '$price$currencySign/$unity',
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: isLarge
          ? Theme.of(context).textTheme.labelLarge!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null)
          : Theme.of(context).textTheme.labelLarge!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null),
    );
  }
}
