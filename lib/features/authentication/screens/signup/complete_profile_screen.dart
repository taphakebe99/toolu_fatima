import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:toolu_fatima/features/authentication/screens/signup/signup.dart';
import 'package:toolu_fatima/features/authentication/screens/signup/widgets/terms_conditions_checkbox.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/validators/validation.dart';
import '../../controllers/signup/signup_controller.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Compléter votre profil'),
      ),
      body: Form(
        key: controller.completeProfileFormKey,
        child: Padding(
          padding: const EdgeInsets.all(MySizes.defaultSpace),
          child: Column(
            children: [
              TextFormField(
                validator: (value) =>
                    MyValidator.validateEmptyText("Le Prénom et le NOM", value),
                controller: controller.fullName,
                decoration: const InputDecoration(
                  labelText: MyTexts.fullName,
                  prefixIcon: Icon(Iconsax.user),
                ),
                onChanged: (_) => controller.updateFormState(),
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
                onChanged: (_) => controller.updateFormState(),
              ),

              const SizedBox(height: MySizes.spaceBtwItems),

              /// Terms and conditions checkbox
              MyTermsAndConditionCheckbox(
                  isDarkMode: MyHelperFunctions.isDarkMode(context)),
              const SizedBox(height: MySizes.spaceBtwSections),

              Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: MyColors.primary,
                      side: const BorderSide(
                        color: Colors.green,
                      ),
                    ),
                    onPressed: controller.isLoading.value
                        ? null
                        : () => controller.validateAndProceed(),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : const Text(
                            MyTexts.continueButton,
                            style: TextStyle(
                              color: MyColors.black,
                            ),
                          ),
                  ),
                ),
              ),

              const SizedBox(height: MySizes.spaceBtwItems),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Colors.green,
                    ),
                  ),
                  onPressed: () => Get.to(() => const SignupScreen()),
                  child: const Text(
                    MyTexts.createAccount,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
