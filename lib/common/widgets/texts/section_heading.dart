import 'package:flutter/material.dart';

class MySectionHeading extends StatelessWidget {
  const MySectionHeading({
    super.key,
    this.textColor,
    this.showActionButton = true,
    this.buttonTitle = const Text(''),
    required this.title,
    this.onPressed,
  });

  final Color? textColor;
  final bool showActionButton;
  final String title;
  final Widget buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton)
          TextButton(onPressed: onPressed, child: buttonTitle),
      ],
    );
  }
}
