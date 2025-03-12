import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class MyFormDivider extends StatelessWidget {
  const MyFormDivider({
    super.key,
    required this.isDarkMode,
    required this.dividerText,
  });

  final bool isDarkMode;
  final String dividerText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color: isDarkMode ? MyColors.darkGrey : MyColors.grey,
            thickness: 0.5,
            indent: 60.0,
            endIndent: 5.0,
          ),
        ),
        Text(
          dividerText,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Flexible(
          child: Divider(
            color: isDarkMode ? MyColors.darkGrey : MyColors.grey,
            thickness: 0.5,
            indent: 5.0,
            endIndent: 60.0,
          ),
        ),
      ],
    );
  }
}
