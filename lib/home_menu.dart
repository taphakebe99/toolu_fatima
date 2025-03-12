import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:toolu_fatima/utils/constants/colors.dart';
import 'package:toolu_fatima/utils/helpers/helper_functions.dart';
import 'features/personalization/screens/settings/settings.dart';
import 'features/shop/screens/home/home.dart';
import 'features/shop/screens/orders/order.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppScreenController());
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          animationDuration: const Duration(seconds: 3),
          selectedIndex: controller.selectedMenu.value,
          backgroundColor: MyHelperFunctions.isDarkMode(context)
              ? MyColors.black
              : Colors.white,
          elevation: 0,
          indicatorColor: MyHelperFunctions.isDarkMode(context)
              ? MyColors.white.withValues(alpha: 0.1)
              : MyColors.black.withValues(alpha: 0.1),
          onDestinationSelected: (index) =>
              controller.selectedMenu.value = index,
          destinations: const [
            NavigationDestination(
              icon: Icon(
                Iconsax.home,
                color: MyColors.primary,
              ),
              label: 'Accueil',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.shopping_basket_outlined,
                color: MyColors.primary,
              ),
              label: 'Commandes',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.person_2_outlined,
                color: MyColors.primary,
              ),
              label: 'Profil',
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedMenu.value]),
    );
  }
}

class AppScreenController extends GetxController {
  static AppScreenController get instance => Get.find();

  final Rx<int> selectedMenu = 0.obs;

  final screens = [
    const HomeScreen(),
    const OrderScreen(),
    const SettingsScreen(),
  ];
}
