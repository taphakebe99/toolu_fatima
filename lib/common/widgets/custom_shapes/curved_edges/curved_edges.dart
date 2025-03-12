import 'package:flutter/material.dart';

/// Custom clipper class that creates a path with curved edges at the bottom.
/// This path design gives a wavy, rounded effect on the lower edge of a widget.
class MyCustomCurvedEdges extends CustomClipper<Path> {
  /// Defines the clipping path for the widget.
  /// The path starts at the top-left corner, moves down, then creates a
  /// series of quadratic curves along the bottom before closing the shape.
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height); // Start at the bottom-left corner

    // Define the first curve on the left side of the bottom edge
    final firstCurved = Offset(0, size.height - 20);
    final lastCurved = Offset(30, size.height - 20);

    path.quadraticBezierTo(
        firstCurved.dx, firstCurved.dy, lastCurved.dx, lastCurved.dy);

    // Define the middle, main curve spanning the width of the widget
    final secondFirstCurved = Offset(0, size.height - 20);
    final secondLastCurved = Offset(size.width - 30, size.height - 20);

    path.quadraticBezierTo(secondFirstCurved.dx, secondFirstCurved.dy,
        secondLastCurved.dx, secondLastCurved.dy);

    // Define the final curve on the right side of the bottom edge
    final thirdFirstCurved = Offset(size.width, size.height - 20);
    final thirdLastCurved = Offset(size.width, size.height);

    path.quadraticBezierTo(thirdFirstCurved.dx, thirdFirstCurved.dy,
        thirdLastCurved.dx, thirdLastCurved.dy);

    path.lineTo(size.width, 0); // Draw a line back to the top-right corner
    path.close(); // Close the path to form a complete shape

    return path;
  }

  /// Specifies whether the clip should be updated if the old clipper instance
  /// is replaced. Here, it always returns true, meaning the path will be
  /// re-evaluated.
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
