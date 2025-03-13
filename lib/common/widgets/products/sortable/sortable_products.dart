import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/all_products_controller.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../layouts/grid_layout.dart';
import '../product_cards/product_card_vertical.dart';

class MySortableProducts extends StatelessWidget {
  const MySortableProducts({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);
    return Column(
      children: [
        /// Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          onChanged: (value) => controller.sortProducts(value!),
          value: controller.selectedSortOption.value.isNotEmpty &&
                  [
                    'Nom',
                    'Prix Élevé',
                    'Prix Bas',
                    'En Vente',
                    'Plus Récents',
                  ].contains(controller.selectedSortOption.value)
              ? controller.selectedSortOption.value
              : null,
          items: [
            'Nom',
            'Prix le plus élevé',
            'Prix le plus bas',
            'Promotion',
            'Le plus récent',
          ]
              .map((option) =>
                  DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
        ),
        const SizedBox(height: MySizes.spaceBtwSections),
        Obx(
          () => MyGridLayout(
            itemCount: controller.products.length,
            itemBuilder: (_, index) => MyProductCardVertical(
                product: controller.products[index], isNetworkImage: true),
          ),
        ),
        SizedBox(
            height: MyDeviceUtility.getBottomNavigationBarHeight() +
                MySizes.defaultSpace),
      ],
    );
  }
}
