import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/validators/validation.dart';
import '../../controllers/address_controller.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      appBar: const MyAppBar(
          showBackArrow: true, title: Text('Ajouter une nouvelle adresse')),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(MySizes.defaultSpace),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: controller.name,
                  validator: (value) =>
                      MyValidator.validateEmptyText('Adresse', value),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user),
                      labelText: 'Veuillez entrer une adresse complète'),
                ),
                const SizedBox(height: MySizes.spaceBtwInputFields),
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
                const SizedBox(height: MySizes.defaultSpace),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(MyColors.primary),
                      ),
                      onPressed: () => controller.addNewAddresses(),
                      child: const Text(
                        'Ajouter',
                        style: TextStyle(color: MyColors.black),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
