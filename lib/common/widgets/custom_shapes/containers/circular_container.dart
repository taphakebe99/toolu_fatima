import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';

class MyCircularContainer extends StatelessWidget {
  const MyCircularContainer({
    super.key,
    this.width = 400.0,
    this.height = 400.0,
    this.radius = 400.0,
    this.padding = 0.0,
    this.child,
    this.backgroundColor = MyColors.white,
    this.margin,
  });

  final double? width;
  final double? height;
  final double radius;
  final double padding;
  final EdgeInsets? margin;
  final Widget? child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}
