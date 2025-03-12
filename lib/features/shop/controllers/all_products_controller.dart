import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/repositories/product/product_repository.dart';
import '../../../utils/popups/loaders.dart';
import '../models/product_model.dart';

class AllProductsController extends GetxController {
  static AllProductsController get instance => Get.find();

  final repository = ProductRepository.instance;
  final RxString selectedSortOption = 'Nom'.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;

  Future<List<ProductModel>> fetchProductsByQuery(Query? query) async {
    try {
      if (query == null) return [];
      // return DummyData.products;
      return await repository.fetchProductsByQuery(query);
    } catch (e) {
      MyLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  void assignProducts(List<ProductModel> products) {
    // Assign products to the 'products' list
    this.products.assignAll(products);
    sortProducts('Nom');
  }

  void sortProducts(String sortOption) {

    selectedSortOption.value = sortOption;


    switch (sortOption) {
      case 'Nom':
        products.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Prix le plus élevé':
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Prix le plus bas':
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      default:
        // Default sorting option: Name
        products.sort((a, b) => a.title.compareTo(b.title));
    }
  }
}
