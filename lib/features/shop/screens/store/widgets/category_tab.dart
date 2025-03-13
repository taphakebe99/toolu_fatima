/*import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/product/product_controller.dart';
import '../../../models/category_model.dart';

class MyCategoryTab extends StatelessWidget {
  const MyCategoryTab({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());

    return FutureBuilder(
        future: productController.allProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'Aucune donnée disponible.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }

          final products = snapshot.data!
              .where((product) => category.id == product.categoryId)
              .toList();

          if (products.isEmpty) {
            return Center(
              child: Text(
                'Aucune donnée disponible.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }

          return ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(MySizes.defaultSpace),
                  child: Column(
                    children: [
                      const SizedBox(height: MySizes.spaceBtwItems),
                      MyGridLayout(
                        itemCount: products.length,
                        itemBuilder: (_, index) {
                          final product = products[index];
                          return MyProductCardVertical(
                            product: product,
                            isNetworkImage: true,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ]);
        });
  }
}
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/product/product_controller.dart';
import '../../../models/category_model.dart';

class MyCategoryTab extends StatelessWidget {
  const MyCategoryTab({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());

    return Obx(() {
      if (productController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (productController.allProducts.isEmpty) {
        return Center(
          child: Text(
            'Aucune donnée disponible.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        );
      }

      final products = productController.allProducts
          .where((product) => category.id == product.categoryId)
          .toList();

      if (products.isEmpty) {
        return Center(
          child: Text(
            'Aucun produit trouvé pour cette catégorie.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        );
      }

      return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(MySizes.defaultSpace),
            child: Column(
              children: [
                const SizedBox(height: MySizes.spaceBtwItems),
                MyGridLayout(
                  itemCount: products.length,
                  itemBuilder: (_, index) {
                    final product = products[index];
                    return MyProductCardVertical(
                      product: product,
                      isNetworkImage: true,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
