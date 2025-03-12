import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/login/login_controller.dart';
import '../../password_configuration/forget_password.dart';
import '../../signup/signup.dart';

/// A login form widget for user authentication.
///
/// Contains fields for email, password, options for "Remember Me" and "Forgot Password",
/// along with "Sign In" and "Create Account" buttons.
class MyLoginForm extends StatelessWidget {
  const MyLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Form(
      key: controller.loginFormKey,
      // Adds padding around the form for consistent spacing.
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: MySizes.spaceBtwSections,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              validator: (value) => MyValidator.validateEmail(value),
              controller: controller.email,
              keyboardType: TextInputType.emailAddress,
              expands: false,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.mail_outline),
              ),
            ),

            const SizedBox(height: MySizes.spaceBtwInputFields),

            /// Password
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) => MyValidator.validatePassword(value),
                obscureText: controller.hidePassword.value,
                expands: false,
                decoration: InputDecoration(
                  labelText: MyTexts.password,
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    //onPressed: () => () {},
                    icon: Icon(controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: MySizes.spaceBtwInputFields,
            ),
            Wrap(
              alignment: WrapAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(
                      () => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) {
                          controller.rememberMe.value =
                              !controller.rememberMe.value;
                        },
                      ),
                    ),
                    const Text('Se souvenir de moi'),
                  ],
                ),
                TextButton(
                  onPressed: () => Get.to(() => const ForgetPassword()),
                  child: const Text('Mot de passe oublié'),
                ),
              ],
            ),

            const SizedBox(
                height: MySizes.spaceBtwSections), // Spacing before buttons

            // "Sign In" Button
            Obx(
              () => SizedBox(
                width: double.infinity, // Makes button full-width
                child: ElevatedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: MyColors.primary,
                    side: const BorderSide(
                      color: Colors.green,
                    ), // Border color
                  ),
                  onPressed: controller.isLoading.value
                      ? null // Désactive le bouton si en cours de chargement
                      : () => controller.emailAndPasswordSignIn(),
                  //onPressed: () => controller.emailAndPasswordSignIn(),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : const Text(
                          MyTexts.signIn,
                          style: TextStyle(
                            color: MyColors.black,
                          ),
                        ), // Button text for "Sign In"
                ),
              ),
            ),
            const SizedBox(height: MySizes.spaceBtwItems),

            // "Create Account" Button
            SizedBox(
              width: double.infinity, // Full-width outlined button
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.green), // Border color
                ),
                onPressed: () => Get.to(() => const SignupScreen()),
                child: const Text(
                  MyTexts.createAccount,
                ), // Button text for "Create Account"
              ),
            ),
            const SizedBox(height: MySizes.spaceBtwItems),

            // "Create Account" Button
            SizedBox(
              width: double.infinity, // Full-width outlined button
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: MyColors.primary,
                  side: const BorderSide(color: Colors.green), // Border color
                ),
                onPressed: () => controller.anonymousSignIn(),

                child: const Text(
                  MyTexts.discovery,
                ), // Button text for "Create Account"
              ),
            ),
          ],
        ),
      ),
    );
  }
}
