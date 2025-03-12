import 'package:flutter/material.dart';
import 'package:toolu_fatima/features/authentication/screens/password_configuration/reset_password.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(MySizes.defaultSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /// Headings
            Text(
              MyTexts.forgetPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: MySizes.spaceBtwItems),
            Text(
              MyTexts.forgetPasswordSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: MySizes.spaceBtwSections * 2),

            Form(
              // key: controller.forgetPasswordFormKey,
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                expands: false,
                decoration: const InputDecoration(
                  labelText: MyTexts.email,
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
            ),
            const SizedBox(height: MySizes.spaceBtwSections),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => const ResetPassword(email: ''),
                child: const Text(MyTexts.submit),
              ),
            )

            /// Submit Button
          ],
        ),
      ),
    );
  }
}
