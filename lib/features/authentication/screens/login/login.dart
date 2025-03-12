import 'package:flutter/material.dart';
import 'package:toolu_fatima/features/authentication/screens/login/widgets/login_form.dart';
import 'package:toolu_fatima/features/authentication/screens/login/widgets/login_header.dart';

import '../../../../common/styles/spacing_styles.dart';

import '../../../../utils/helpers/helper_functions.dart';

/// The main login screen for the app, displaying the login header, form, and social login options.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if the current theme is dark mode.
    final isDarkMode = MyHelperFunctions.isDarkMode(context);
    //final controller = Get.put(LoginController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: MySpacingStyle
              .paddingWithAppBarHeight, // Adds padding based on app bar height
          child: Column(
            children: [
              // Displays the header with logo and welcome text.
              MyLoginHeader(isDarkMode: isDarkMode),

              // Login form with email, password fields, and login button.
              const MyLoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
