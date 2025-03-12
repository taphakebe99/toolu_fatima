import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/icons/my_circular_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/address_controller.dart';
import '../../../models/address_model.dart';
import '../update_address.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress({
    super.key,
    required this.address,
    required this.onTap,
  });

  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final dark = MyHelperFunctions.isDarkMode(context);

    return Dismissible(
      key: Key(address.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white, size: 30),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirmer la suppression"),
              content: const Text(
                  "Êtes-vous sûr de vouloir supprimer cette adresse ?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Annuler"),
                ),
                TextButton(
                  onPressed: () async {
                    await controller.deleteAddress(address.id);
                    Navigator.of(context).pop(true);
                  },
                  child: const Text("Supprimer",
                      style: TextStyle(color: Colors.red)),
                ),
              ],
            );
          },
        );
      },
      child: GestureDetector(
        onTap: onTap,
        child: MyRoundedContainer(
          showBorder: true,
          padding: const EdgeInsets.all(MySizes.md),
          width: double.infinity,
          backgroundColor: Colors.transparent,
          borderColor: dark ? MyColors.darkerGrey : MyColors.grey,
          margin: const EdgeInsets.only(bottom: MySizes.spaceBtwItems),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                child: MyCircularIcon(
                  backgroundColor: MyColors.primary.withValues(alpha: 0.6),
                  width: 42,
                  height: 42,
                  size: MySizes.md,
                  color: Colors.white,
                  icon: Iconsax.edit_24,
                  onPressed: () =>
                      Get.to(() => UpdateAddressScreen(address: address)),
                ),
              ),
              Row(
                children: [
                  const Icon(Iconsax.home, color: MyColors.primary),
                  const SizedBox(width: MySizes.spaceBtwItems),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          address.phoneNumber,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: MySizes.sm / 2),
                        Text(
                          address.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
