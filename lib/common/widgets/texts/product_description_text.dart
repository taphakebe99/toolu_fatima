import 'package:flutter/material.dart';

class MyProductDescriptionText extends StatelessWidget {
  const MyProductDescriptionText({
    super.key,
    required this.description,
    this.smallSize = false,
    this.maxLine = 2,
    this.textAlign = TextAlign.left,
  });

  final String description;
  final bool smallSize;
  final int maxLine;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: (smallSize
              ? Theme.of(context).textTheme.labelLarge
              : Theme.of(context).textTheme.titleSmall)
          ?.copyWith(
        color: Colors.grey,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLine,
      textAlign: textAlign,
    );
  }
}
