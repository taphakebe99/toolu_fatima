import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../data/repositories/product/product_repository.dart';
import '../models/product_model.dart';

class MySearchController extends GetxController {
  static MySearchController get instance => Get.find();

  RxList<ProductModel> searchResults = <ProductModel>[].obs;
  RxBool isLoading = false.obs;
  RxString lastSearchQuery = ''.obs;
  RxDouble minPrice = 0.0.obs;
  RxDouble maxPrice = double.infinity.obs;
  final RxString searchQuery = ''.obs;
  final RxString selectedCategoryId = ''.obs;
  List<String> sortingOptions = [
    'Nom',
    'Prix le plus bas',
    'Prix le plus élevé',
  ];

  RxString selectedSortingOption = 'Nom'.obs; // Default sorting option

  void search() {
    searchProducts(
      searchQuery.value,
      categoryId:
          selectedCategoryId.value.isNotEmpty ? selectedCategoryId.value : null,
      minPrice: minPrice.value != 0.0 ? minPrice.value : null,
      maxPrice: maxPrice.value != double.infinity ? maxPrice.value : null,
    );
  }

  void searchProducts(String query,
      {String? categoryId,
      String? brandId,
      double? minPrice,
      double? maxPrice}) async {
    lastSearchQuery.value = query;
    isLoading.value = true;

    try {
      final results = await ProductRepository.instance.searchProducts(query,
          categoryId: categoryId,
          brandId: brandId,
          maxPrice: maxPrice,
          minPrice: minPrice);

      // Apply sorting
      switch (selectedSortingOption.value) {
        case 'Nom':
          // Sort by name
          results.sort((a, b) => a.title.compareTo(b.title));
          break;
        case 'Prix le plus bas':
          // Sort by price in ascending order
          results.sort((a, b) => a.price.compareTo(b.price));
          break;
        case 'Prix le plus élevé':
          // Sort by price in descending order
          results.sort((a, b) => b.price.compareTo(a.price));
          break;
        // Add other sorting cases as needed
      }

      // Update searchResults with sorted results
      searchResults.assignAll(results);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
