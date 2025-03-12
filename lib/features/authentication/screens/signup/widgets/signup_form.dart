import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:toolu_fatima/features/authentication/screens/signup/widgets/terms_conditions_checkbox.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/signup/signup_controller.dart';

class MySignupForm extends StatelessWidget {
  const MySignupForm({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  validator: (value) => MyValidator.validateEmptyText(
                      "Le Prénom et le NOM", value),
                  controller: controller.fullName,
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: MyTexts.fullName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: MySizes.spaceBtwInputFields),

          TextFormField(
            validator: (value) => MyValidator.validateEmail(value),
            controller: controller.email,
            expands: false,
            decoration: const InputDecoration(
              labelText: MyTexts.email,
              prefixIcon: Icon(Icons.mail_outline),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: MySizes.spaceBtwInputFields),

          /// Phone Number
          IntlPhoneField(
            validator: (value) =>
                MyValidator.validatePhoneNumber(value?.completeNumber),
            controller: controller.phoneNumber,
            decoration: InputDecoration(
              labelText: MyTexts.phoneNo,
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
            ),
            initialCountryCode: 'SN',
            keyboardType: TextInputType.number,
            onChanged: (phone) {},
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
                  icon: Icon(controller.hidePassword.value
                      ? Iconsax.eye_slash
                      : Iconsax.eye),
                  //icon: Icon(Iconsax.eye),
                ),
              ),
            ),
          ),
          const SizedBox(height: MySizes.spaceBtwInputFields),

          /// Confirm Password
          Obx(
            () => TextFormField(
              controller: controller.confirmPassword,
              validator: (value) => MyValidator.validatePassword(value),
              obscureText: controller.hideConfirmPassword.value,
              expands: false,
              decoration: InputDecoration(
                labelText: MyTexts.confirmPassword,
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: () => controller.hideConfirmPassword.value =
                      !controller.hideConfirmPassword.value,
                  //onPressed: () => () {},
                  icon: Icon(controller.hideConfirmPassword.value
                      ? Iconsax.eye_slash
                      : Iconsax.eye),
                ),
              ),
            ),
          ),
          const SizedBox(height: MySizes.spaceBtwSections),

          /// Terms and conditions checkbox
          MyTermsAndConditionCheckbox(isDarkMode: isDarkMode),
          const SizedBox(height: MySizes.spaceBtwSections),

          /// Sign up button
          Obx(
            () => SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.primary,
                ),
                onPressed: controller.isLoading.value
                    ? null // Désactive le bouton si en cours de chargement
                    : () {
                        if (controller.signupFormKey.currentState?.validate() ??
                            false) {
                          controller.signup(); // Appelle la fonction de signup
                        }
                      },
                child: controller.isLoading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text(
                        MyTexts.createAccount,
                        style: TextStyle(
                          color: MyColors.black,
                        ),
                      ), // Texte du bouton
              ),
            ),
          )
        ],
      ),
    );
  }
}
