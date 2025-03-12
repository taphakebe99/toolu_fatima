import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/validators/validation.dart';
import '../../controllers/address_controller.dart';
import '../../models/address_model.dart';

class UpdateAddressScreen extends StatelessWidget {
  const UpdateAddressScreen({super.key, required this.address});

  final AddressModel address;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    controller.initUpdateAddressValues(address);
    return Scaffold(
      appBar:
          const MyAppBar(showBackArrow: true, title: Text('Modifier Adresse')),
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
                      MyValidator.validateEmptyText('Name', value),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user),
                      labelText: 'Veuillez entrer une adresse complète'),
                ),
                const SizedBox(height: MySizes.spaceBtwInputFields),
                TextFormField(
                  controller: controller.phoneNumber,
                  validator: (value) =>
                      MyValidator.validateEmptyText('Numéro téléphone', value),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.mobile),
                      labelText: 'Numéro téléphone'),
                ),
                const SizedBox(height: MySizes.defaultSpace),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => controller.updateAddress(address),
                      child: const Text('Enregistrer')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
