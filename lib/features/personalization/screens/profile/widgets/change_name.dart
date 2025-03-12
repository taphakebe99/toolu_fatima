import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/button/my_button_widget.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/update_name_controller.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());

    return Scaffold(
      appBar: MyAppBar(
        showBackArrow: true,
        title: Text(
          'Changer Nom',
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
              'Utilisez votre vrai nom pour une vérification facile. Ce nom apparaîtra sur plusieurs pages et sera utilisé pour la livraison de vos courses.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: MySizes.spaceBtwSections),

            /// TextField and Button
            Form(
              key: controller.updateUserNameFormKey,
              child: TextFormField(
                controller: controller.fullName,
                validator: (value) =>
                    MyValidator.validateEmptyText('Prénom et Nom', value),
                expands: false,
                decoration: InputDecoration(
                  labelText: MyTexts.fullName,
                  prefixIcon: Icon(
                    Icons.person,
                  ),
                ),
              ),
            ),
            const SizedBox(height: MySizes.spaceBtwSections),

            MyButton(
              title: 'Enregistrer',
              onPressed: () => controller.updateUserName(),
            ),
          ],
        ),
      ),
    );
  }
}
