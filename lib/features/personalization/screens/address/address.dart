import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:toolu_fatima/features/personalization/screens/address/widgets/single_address.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/loaders/circular_loader.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../controllers/address_controller.dart';
import 'add_new_address.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      appBar: MyAppBar(
        showBackArrow: true,
        title: Text('Mes Adresses',
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(MySizes.defaultSpace),
        child: Obx(
          () => FutureBuilder(
            // Use key to trigger refresh
            key: Key(controller.refreshData.value.toString()),
            future: controller.allUserAddresses(),
            builder: (_, snapshot) {
              /// Helper Function: Handle Loader, No Record, OR ERROR Message
              final response = MyCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot);
              if (response != null) return response;

              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => SingleAddress(
                  address: snapshot.data![index],
                  onTap: () async {
                    Get.defaultDialog(
                      title: '',
                      onWillPop: () async {
                        return false;
                      },
                      barrierDismissible: false,
                      backgroundColor: Colors.transparent,
                      content: const MyCircularLoader(),
                    );
                    await controller.selectAddress(
                        newSelectedAddress: snapshot.data![index]);
                    Get.back();
                  },
                ),
              );
            },
          ),
        ),
      ),

      /// Add new Address button
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.primary,
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: const Icon(Iconsax.add, color: MyColors.white),
      ),
    );
  }
}
