import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/user_controller.dart';

class ReAuthUserLoginForm extends StatelessWidget {
  const ReAuthUserLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: MyAppBar(
        title: const Text('Ré-authentifier l\'utilisateur'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MySizes.defaultSpace),
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  validator: MyValidator.validateEmail,
                  controller: controller.verifyEmail,
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: MyTexts.email,
                    prefixIcon: Icon(Icons.mail_outline),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: MySizes.spaceBtwInputFields),

                /// Password
                Obx(
                  () => TextFormField(
                    controller: controller.verifyPassword,
                    validator: (value) =>
                        MyValidator.validateEmptyText('Mot de passe', value),
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
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: MySizes.spaceBtwSections),

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
                              if (controller.reAuthFormKey.currentState
                                      ?.validate() ??
                                  false) {
                                controller.reAuthenticateEmailAndPasswordUser();
                              }
                            },
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : const Text(
                              MyTexts.verify,
                              style: TextStyle(
                                color: MyColors.black,
                              ),
                            ), // Texte du bouton
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
