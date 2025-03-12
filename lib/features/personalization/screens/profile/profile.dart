import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:toolu_fatima/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:toolu_fatima/features/personalization/screens/profile/widgets/change_number.dart';
import 'package:toolu_fatima/features/personalization/screens/profile/widgets/profile_menu.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/images/my_circular_image.dart';
import '../../../../common/widgets/shimmers/shimmer.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../home_menu.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/user_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: MyAppBar(
        showBackArrow: true,
        arrowBackOnPressed: () => Get.off(() => const HomeMenu()),
        title: const Text('Profil'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MySizes.defaultSpace),
          child: Column(
            children: [
              /// Profile picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(
                      () {
                        final networkImage =
                            controller.user.value.profilePicture;
                        final image = networkImage.isNotEmpty
                            ? networkImage
                            : MyImages.user;
                        return controller.imageLoading.value
                            ? const MyShimmerEffect(
                                width: 80,
                                height: 80,
                                radius: 80,
                              )
                            : MyCircularImage(
                                image: image,
                                width: 80,
                                height: 80,
                                isNetworkImage: networkImage.isNotEmpty,
                              );
                      },
                    ),
                    TextButton(
                      onPressed: () => controller.uploadUserProfilePicture(),
                      child: const Text('Changer la photo de profil'),
                    ),
                  ],
                ),
              ),

              /// Details
              const SizedBox(height: MySizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: MySizes.spaceBtwItems),

              /// Heading profile info
              const MySectionHeading(
                title: 'Informations de profil',
                showActionButton: false,
              ),
              const SizedBox(height: MySizes.spaceBtwItems),

              Obx(() {
                return MyProfileMenu(
                  onPressed: () => Get.to(() => const ChangeName()),
                  title: 'Nom',
                  value: controller.user.value.fullName,
                );
              }),

              const SizedBox(height: MySizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: MySizes.spaceBtwItems),

              /// Heading personal info
              const MySectionHeading(
                title: 'Informations personnelles',
                showActionButton: false,
              ),
              const SizedBox(height: MySizes.spaceBtwItems),
              MyProfileMenu(
                onPressed: () {},
                title: 'ID utilisateur',
                value: controller.user.value.id,
                icon: Iconsax.copy,
              ),

              MyProfileMenu(
                onPressed: () => Get.to(() => const ChangeNumber()),
                title: 'Numéro de téléphone',
                value: controller.user.value.phoneNumber,
              ),

              const Divider(),
              const SizedBox(height: MySizes.spaceBtwItems),
              Center(
                child: TextButton(
                  onPressed: (controller.user.value.fullName == "" ||
                          controller.user.value.phoneNumber == "")
                      ? null // Le bouton sera désactivé si nom ou phoneNumber est vide
                      : () => controller.deleteAccountWarningPopup(),
                  // Sinon, il reste cliquable
                  child: Text(
                    'Fermer le compte',
                    style: TextStyle(
                      color: (controller.user.value.fullName == "" ||
                              controller.user.value.phoneNumber == "")
                          ? Colors
                              .grey
                          : Colors
                              .red,
                    ),
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
