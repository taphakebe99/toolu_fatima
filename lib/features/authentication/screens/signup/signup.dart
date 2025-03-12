import 'package:flutter/material.dart';
import 'package:toolu_fatima/features/authentication/screens/signup/widgets/signup_form.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = MyHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MySizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Tittle
              Text(
                MyTexts.signUpTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: MySizes.spaceBtwSections),

              /// Form
              MySignupForm(isDarkMode: isDarkMode),
            ],
          ),
        ),
      ),
    );
  }
}
