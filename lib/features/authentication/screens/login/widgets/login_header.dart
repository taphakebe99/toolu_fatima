import 'package:flutter/material.dart';

import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/text_strings.dart';

/// A widget that displays the login screen's header, including the logo and introductory text.
///
/// The appearance of the logo adapts based on the provided `isDarkMode` boolean.
class MyLoginHeader extends StatelessWidget {
  // Constructor accepting `isDarkMode` to adjust logo appearance for light or dark mode.
  const MyLoginHeader({
    super.key,
    required this.isDarkMode,
  });

  // Indicates whether dark mode is enabled, affecting the displayed logo.
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          MyTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,
        ),

        Image(
          height: 150.0,
          image: AssetImage(
            isDarkMode ? MyImages.lightAppLogo : MyImages.darkAppLogo,
          ),
        ),

      ],
    );
  }
}
