import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.title, this.onPressed});

  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final isDark = MyHelperFunctions.isDarkMode(context);
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: isDark ? MyColors.darkerGrey : MyColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(MySizes.cardRadiusLg),
          topRight: Radius.circular(MySizes.cardRadiusLg),
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.primary,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(fontSize: 16, color: MyColors.black),
        ),
      ),
    );
  }
}
