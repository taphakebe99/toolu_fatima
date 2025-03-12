import 'package:get/get.dart';

import '../../../../data/repositories/product/product_repository.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  RxList<ProductModel> products = <ProductModel>[].obs;

  /// -- Initialize Products from your backend
  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  /// Fetch Products using Stream so, any change can immediately take effect.
  Future<List<ProductModel>> fetchProducts() async {
    try {
      // Show loader while loading Products
      isLoading.value = true;

      // Fetch Products
      final products = await productRepository.getProducts();

      // Return fetched products
      return products;
    } catch (e) {
      MyLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return []; // Return an empty list in case of error
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetch a specific product by ID
  Future<ProductModel?> fetchProductById(String id) async {
    try {
      isLoading.value = true;
      final product = await productRepository.getSingleProduct(id);
      return product;
    } catch (e) {
      MyLoaders.errorSnackBar(title: 'Error', message: e.toString());
      return null;
    } finally {
      isLoading.value = false;
    }
  }
}
