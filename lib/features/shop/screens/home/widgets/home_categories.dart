import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../controllers/category_controller.dart';
import '../../../controllers/product/product_controller.dart';
import '../../store/store.dart';

class HomeCategorySection extends StatelessWidget {
  const HomeCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    final productController = Get.put(ProductController());

    return FutureBuilder(
      future: productController
          .fetchProducts()
          .then((_) => productController.allProducts),
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

        final parentsCategories = categoryController.allCategories
            .where((category) => category.parentId == '')
            .toList();

        final subCategories = categoryController.allCategories
            .where((category) => category.parentId.isNotEmpty)
            .toList();

        final filteredCategories = parentsCategories.where((category) {
          final typeCategories = subCategories
              .where((cat) => cat.parentId == category.id)
              .toList();

          return snapshot.data!.any((product) =>
              typeCategories.any((cat) => cat.id == product.categoryId));
        }).toList();

        if (filteredCategories.isEmpty) {
          return Center(
            child: Text(
              'Aucune catégorie avec des produits.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: filteredCategories.length,
          itemBuilder: (context, index) {
            final category = filteredCategories[index];
            final typeCategories = subCategories
                .where((cat) => cat.parentId == category.id)
                .toList();

            final products = snapshot.data!
                .where((product) =>
                    typeCategories.any((cat) => cat.id == product.categoryId))
                .toList();

            products.shuffle(Random());

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MySectionHeading(
                  buttonTitle: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                    padding: const EdgeInsets.all(MySizes.defaultSpace / 3),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                  title: category.name,
                  onPressed: () => Get.to(
                    () => StoreScreen(
                      title: category.name,
                      parentId: category.id,
                    ),
                  ),
                ),
                const SizedBox(height: MySizes.spaceBtwItems),
                MyGridLayout(
                  itemCount: products.length.clamp(0, 5),
                  itemBuilder: (_, index) => MyProductCardVertical(
                    isNetworkImage: true,
                    product: products[index],
                  ),
                ),
                SizedBox(
                  height: MyDeviceUtility.getBottomNavigationBarHeight() +
                      MySizes.defaultSpace,
                ),
              ],
            );
          },
        );
      },
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../controllers/category_controller.dart';
import '../../../controllers/product/product_controller.dart';
import '../../store/store.dart';

class HomeCategorySection extends StatelessWidget {
  const HomeCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    final productController = Get.put(ProductController());

    return FutureBuilder(
      future: Future.wait([
        categoryController.fetchCategories(), // Récupérer les catégories
        productController.fetchProducts(), // Récupérer les produits
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        }

        print("snapshot:  ${snapshot.data}");

        // Vérifier si les données sont bien chargées
        if (!snapshot.hasData ||
            categoryController.allCategories.isEmpty ||
            productController.allProducts.isEmpty) {
          return Center(
            child: Text(
              'Aucune donnée disponible.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }

        // Filtrer les catégories parents
        final parentsCategories = categoryController.allCategories
            .where((category) => category.parentId.isEmpty)
            .toList();

        print("parentsCategories:  ${parentsCategories}");

        if (parentsCategories.isEmpty) {
          return Center(
            child: Text(
              'Aucune catégorie parent trouvée.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }

        print("parentsCategories:  ${parentsCategories}");

        // Filtrer les sous-catégories
        final subCategories = categoryController.allCategories
            .where((category) => category.parentId.isNotEmpty)
            .toList();

        // Filtrer les catégories ayant des produits
        final filteredCategories = parentsCategories.where((category) {
          final typeCategories = subCategories
              .where((cat) => cat.parentId == category.id)
              .toList();

          return productController.allProducts.any((product) =>
              typeCategories.any((cat) => cat.id == product.categoryId));
        }).toList();

        if (filteredCategories.isEmpty) {
          return Center(
            child: Text(
              'Aucune catégorie contenant des produits.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: filteredCategories.length,
          itemBuilder: (context, index) {
            final category = filteredCategories[index];
            final typeCategories = subCategories
                .where((cat) => cat.parentId == category.id)
                .toList();

            final products = productController.allProducts
                .where((product) =>
                    typeCategories.any((cat) => cat.id == product.categoryId))
                .toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MySectionHeading(
                  buttonTitle: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                    padding: const EdgeInsets.all(MySizes.defaultSpace / 3),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                  title: category.name,
                  onPressed: () => Get.to(
                    () => StoreScreen(
                      title: category.name,
                      parentId: category.id,
                    ),
                  ),
                ),
                const SizedBox(height: MySizes.spaceBtwItems),
                MyGridLayout(
                  itemCount: products.length.clamp(0, 5),
                  itemBuilder: (_, index) => MyProductCardVertical(
                    isNetworkImage: true,
                    product: products[index],
                  ),
                ),
                SizedBox(
                  height: MyDeviceUtility.getBottomNavigationBarHeight() +
                      MySizes.defaultSpace,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
*/
