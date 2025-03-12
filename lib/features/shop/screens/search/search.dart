import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/category_controller.dart';
import '../../controllers/search_controller.dart';
import '../../models/category_model.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final categoryController = CategoryController.instance;
  final searchController = Get.put(MySearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('Recherche',
            style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Annuler'))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MySizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Search bar & Filter Button
              Row(
                children: [
                  /// Search
                  Expanded(
                    child: TextFormField(
                      autofocus: true,
                      onChanged: (search) =>
                          searchController.searchProducts(search),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.search_normal),
                          hintText: 'Recherche'),
                    ),
                  ),
                  const SizedBox(width: MySizes.spaceBtwItems),

                  /// Filter
                  OutlinedButton(
                    onPressed: () => filterModalBottomSheet(context),
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.grey)),
                    child: const Icon(Iconsax.setting, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: MySizes.spaceBtwSections),

              /// Search
              Obx(
                () => searchController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    :
                    // Show search if not Empty
                    searchController.searchResults.isNotEmpty
                        ? MyGridLayout(
                            itemCount: searchController.searchResults.length,
                            itemBuilder: (_, index) => MyProductCardVertical(
                                product: searchController.searchResults[index]),
                          )
                        : Text(''),
              ),

              const SizedBox(height: MySizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> filterModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: MySizes.defaultSpace,
          right: MySizes.defaultSpace,
          top: MySizes.defaultSpace,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Heading
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MySectionHeading(
                      title: 'Filtrer', showActionButton: false),
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Iconsax.close_square))
                ],
              ),
              const SizedBox(height: MySizes.spaceBtwSections / 2),

              /// Sort
              /* Text('Trier par', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: MySizes.spaceBtwItems / 2),

               _buildSortingDropdown(),
              const SizedBox(height: MySizes.spaceBtwSections),*/

              /// Categories

              Text('Catégorie', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: MySizes.spaceBtwItems),
              _buildCategoryList(),
              const SizedBox(height: MySizes.spaceBtwSections),

              /// Sort by Radios
              Text('Prix', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: MySizes.spaceBtwItems / 2),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) =>
                          searchController.minPrice.value = double.parse(value),
                      decoration: const InputDecoration(
                        hintText: 'Le plus bas',
                      ),
                    ),
                  ),
                  const SizedBox(width: MySizes.spaceBtwItems),
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) =>
                          searchController.maxPrice.value = double.parse(value),
                      decoration:
                          const InputDecoration(hintText: 'Le plus élevé'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: MySizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    searchController.search();
                    Get.back();
                  },
                  child: const Text('Appliquer'),
                ),
              ),
              const SizedBox(height: MySizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildCategoryList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: categoryController.allCategories.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _buildCategoryTile(categoryController.allCategories[index]);
      },
    );
  }

  Widget _buildCategoryTile(CategoryModel category) {
    return category.parentId.isEmpty
        ? Obx(() => _buildParentCategoryTile(category))
        : const SizedBox.shrink();
  }

  Widget _buildParentCategoryTile(CategoryModel category) {
    return ExpansionTile(
      title: Text(category.name),
      children: _buildSubCategories(category.id),
    );
  }

  List<Widget> _buildSubCategories(String parentId) {
    List<CategoryModel> subCategories = categoryController.allCategories
        .where((cat) => cat.parentId == parentId)
        .toList();
    return subCategories
        .map((subCategory) => _buildSubCategoryTile(subCategory))
        .toList();
  }

  Widget _buildSubCategoryTile(CategoryModel category) {
    return RadioListTile(
      title: Text(category.name),
      value: category.id,
      groupValue: searchController.selectedCategoryId.value,
      onChanged: (value) {
        searchController.selectedCategoryId.value = value.toString();
      },
    );
  }
}
