import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/button/my_button_widget.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/update_phone_number_controller.dart';

class ChangeNumber extends StatelessWidget {
  const ChangeNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdatePhoneNumberController());

    return Scaffold(
      appBar: MyAppBar(
        showBackArrow: true,
        title: Text(
          'Changer Numéro téléphone',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(MySizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// headings
            Text(
              'Utilisez un numéro valide. Ce nom apparaîtra sur plusieurs pages et sera utilisé pour la livraison de vos courses.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: MySizes.spaceBtwSections),

            /// Phone Number
            Form(
              key: controller.updateUserPhoneNumberFormKey,
              child: IntlPhoneField(
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
            ),
            const SizedBox(height: MySizes.spaceBtwSections),

            MyButton(
              title: 'Enregistrer',
              onPressed: () => controller.updateUserPhoneNumber(),
            ),
          ],
        ),
      ),
    );
  }
}
