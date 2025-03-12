import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/list_tiles/settings_menu_tile.dart';
import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../authentication/screens/signup/signup.dart';
import '../../../shop/screens/orders/order.dart';
import '../address/address.dart';
import '../profile/profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            MyPrimaryHeaderContainer(
              child: Column(
                children: [
                  MyAppBar(
                    title: Text(
                      'Mon Compte',
                      style: Theme.of(context).textTheme.headlineMedium!.apply(
                            color: MyColors.black,
                          ),
                    ),
                  ),

                  /// USer profile card
                  MyUserProfileTile(
                      onPressed: () => Get.to(() => const ProfileScreen())),
                  const SizedBox(height: MySizes.spaceBtwSections),
                ],
              ),
            ),

            /// Body
            Padding(
              padding: const EdgeInsets.all(MySizes.defaultSpace),
              child: Column(
                children: [
                  /// Paramètres du compte
                  const MySectionHeading(
                    title: 'Paramètres',
                    showActionButton: false,
                  ),
                  const SizedBox(height: MySizes.spaceBtwItems),

                  SettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'Mon adresse',
                    subTitle: 'Définir l\'adresse de livraison de vos achats',
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),

                  SettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'Mes commandes',
                    subTitle: 'Commandes en cours et terminées',
                    onTap: () => Get.to(() => OrderScreen()),
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.security_card,
                    title: 'Confidentialité du compte',
                    subTitle:
                        'Gérer l\'utilisation des données et les comptes connectés',
                    onTap: () {},
                  ),

                  /// Bouton de déconnexion
                  const SizedBox(height: MySizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: (AuthenticationRepository
                            .instance.firebaseUser!.isAnonymous)
                        ? SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Colors.green,
                                ),
                              ),
                              onPressed: () =>
                                  Get.to(() => const SignupScreen()),
                              child: const Text(
                                MyTexts.createAccount,
                              ),
                            ),
                          )
                        : OutlinedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(MyColors.primary),
                            ),
                            onPressed: () =>
                                AuthenticationRepository.instance.logout(),
                            child: const Text('Déconnexion'),
                          ),
                  ),

                  const SizedBox(height: MySizes.spaceBtwSections * 3.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
