/*import 'package:get/get.dart';

import '../../../../data/repositories/product/product_repository.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  RxList<ProductModel> products_old = <ProductModel>[].obs;

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
      final products_old = await productRepository.getProducts();

      // Return fetched products_old
      return products_old;
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
*/

import 'package:get/get.dart';

import '../../../../data/repositories/product/product_repository.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  RxList<ProductModel> allProducts = <ProductModel>[].obs;

  /// -- Initialize Products from your backend
  @override
  void onInit() {
    fetchFeaturedProducts();
    fetchProducts();

    super.onInit();
  }

  /// Fetch Products using Stream so, any change can immediately take effect.
  void fetchFeaturedProducts() async {
    try {
      // Show loader while loading Products
      isLoading.value = true;

      // Fetch Products
      final products = await productRepository.getFeaturedProducts();

      // Assign Products
      featuredProducts.assignAll(products);
    } catch (e) {
      MyLoaders.errorSnackBar(title: 'Oups!', message: e.toString());
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

  /// Fetch Products using Stream so, any change can immediately take effect.
  Future<void> fetchProducts() async {
    try {
      // Show loader while loading Products
      isLoading.value = true;

      // Fetch Products
      final products = await productRepository.getProducts();
      allProducts.assignAll(products);
    } catch (e) {
      MyLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Get the product price or price range for variations.
  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    // If no variations exist, return the simple price or sale price
    if (product.productType == ProductType.single.toString() ||
        product.productVariations!.isEmpty) {
      return '${(product.salePrice > 0.0 ? product.salePrice : product.price).toStringAsFixed(2)} CFA';
    } else {
      // Calculate the smallest and largest prices among variations
      for (var variation in product.productVariations!) {
        // Determine the price to consider (sale price if available, otherwise regular price)
        double priceToConsider =
            variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        // Update smallest and largest prices
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }

        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }

      // If smallest and largest prices are the same, return a single price
      if (smallestPrice.isEqual(largestPrice)) {
        return '${largestPrice.toStringAsFixed(2)} CFA';
      } else {
        // Otherwise, return a price range
        return '$smallestPrice - $largestPrice CFA';
      }
    }
  }

  /// -- Calculate Discount Percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0.0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(2);
  }

  /// -- Check Product Stock Status
  String getProductStockStatus(ProductModel product) {
    if (product.productType == ProductType.single.toString()) {
      return product.stock > 0 ? 'En Stock' : 'En Rupture de Stock';
    } else {
      final stock = product.productVariations
          ?.fold(0, (previousValue, element) => previousValue + element.stock);
      return stock != null && stock > 0 ? 'En Stock' : 'En Rupture de Stock';
    }
  }

  Future<void> updateProductStock(
      String productId, int quantitySold, String variationId) async {
    try {
      // Fetch Products
      final product = await productRepository.getSingleProduct(productId);

      if (variationId.isEmpty) {
        product.stock -= quantitySold;
        product.soldQuantity += quantitySold;

        await productRepository.updateProduct(product);
      } else {
        final variation = product.productVariations!
            .where((variation) => variation.id == variationId)
            .first;
        variation.stock -= quantitySold;
        variation.soldQuantity += quantitySold;

        await productRepository.updateProduct(product);
      }
    } catch (e) {
      MyLoaders.errorSnackBar(title: 'Oups!', message: e.toString());
    }
  }
}
