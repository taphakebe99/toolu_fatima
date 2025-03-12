import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class MyRoundedContainer extends StatelessWidget {
  const MyRoundedContainer({
    super.key,
    this.width,
    this.height,
    this.radius = MySizes.cardRadiusLg,
    this.padding,
    this.child,
    this.backgroundColor = MyColors.white,
    this.borderColor = MyColors.borderPrimary,
    this.margin,
    this.showBorder = false,
  });

  final double? width;
  final double? height;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final Color backgroundColor;
  final Color borderColor;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor) : null,
        color: backgroundColor,
      ),
      child: child,
    );
  }
}
