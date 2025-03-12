import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/product_model.dart';
import '../../../utils/exceptions/My_general_exception.dart';
import '../../../utils/exceptions/my_firebase_exception.dart';
import '../../../utils/exceptions/my_format_exception.dart';
import '../../../utils/exceptions/my_platform_exception.dart';

/// Repository for managing product-related data and operations.
class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  /// Firestore instance for database interactions.
  final _db = FirebaseFirestore.instance;

  /* ---------------------------- FUNCTIONS ---------------------------------*/

  /// Get limited featured products.
  Future<List<ProductModel>> getProducts() async {
    try {
      final snapshot = await _db.collection('Products').get();
      return snapshot.docs
          .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw MyGeneralException().message;
    }
  }

  /// Get limited featured products.
  Future<ProductModel> getSingleProduct(String productId) async {
    try {
      final snapshot = await _db.collection('Products').doc(productId).get();
      return ProductModel.fromSnapshot(snapshot);
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw MyGeneralException().message;
    }
  }

  /// Get all featured products using Stream.
  Future<List<ProductModel>> getAllFeaturedProducts() async {
    final snapshot = await _db
        .collection('Products')
        .where('IsFeatured', isEqualTo: true)
        .get();
    return snapshot.docs
        .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
        .toList();
  }

  /// Get Products based on the Brand
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
      return productList;
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw MyGeneralException().message;
    }
  }

  /// Fetches products for a specific category.
  /// If the limit is -1, retrieves all products for the category; otherwise, limits the result based on the provided limit.
  /// Returns a list of [ProductModel] objects.
  Future<List<ProductModel>> getProductsForCategory(
      {required String categoryId, int limit = 4}) async {
    try {
      // Query to get all documents where productId matches the provided categoryId & Fetch limited or unlimited based on limit
      QuerySnapshot productCategoryQuery = limit == -1
          ? await _db
              .collection('ProductCategory')
              .where('categoryId', isEqualTo: categoryId)
              .get()
          : await _db
              .collection('ProductCategory')
              .where('categoryId', isEqualTo: categoryId)
              .limit(limit)
              .get();

      // Extract productIds from the documents
      List<String> productIds = productCategoryQuery.docs
          .map((doc) => doc['productId'] as String)
          .toList();

      // Query to get all documents where the brandId is in the list of brandIds, FieldPath.documentId to query documents in Collection
      final productsQuery = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      // Extract brand names or other relevant data from the documents
      List<ProductModel> products = productsQuery.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

      return products;
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw MyGeneralException().message;
    }
  }

  /// Fetches products for a specific brand.
  /// If the limit is -1, retrieves all products for the brand; otherwise, limits the result based on the provided limit.
  /// Returns a list of [ProductModel] objects.
  Future<List<ProductModel>> getProductsForBrand(
      String brandId, int limit) async {
    try {
      // Query to get all documents where productId matches the provided categoryId & Fetch limited or unlimited based on limit
      QuerySnapshot<Map<String, dynamic>> querySnapshot = limit == -1
          ? await _db
              .collection('Products')
              .where('Brand.Id', isEqualTo: brandId)
              .get()
          : await _db
              .collection('Products')
              .where('Brand.Id', isEqualTo: brandId)
              .limit(limit)
              .get();

      // Map Products
      final products = querySnapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

      return products;
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw MyGeneralException().message;
    }
  }

  Future<List<ProductModel>> searchProducts(String query,
      {String? categoryId,
      String? brandId,
      double? minPrice,
      double? maxPrice}) async {
    try {
      // Reference to the 'products' collection in Firestore
      CollectionReference productsCollection =
          FirebaseFirestore.instance.collection('Products');

      // Start with a basic query to search for products where the name contains the query
      Query queryRef = productsCollection;

      // Apply the search filter
      if (query.isNotEmpty) {
        queryRef = queryRef
            .where('Title', isGreaterThanOrEqualTo: query)
            .where('Title', isLessThanOrEqualTo: '$query\uf8ff');
      }

      // Apply filters
      if (categoryId != null) {
        queryRef = queryRef.where('CategoryId', isEqualTo: categoryId);
      }

      if (minPrice != null) {
        queryRef = queryRef.where('Price', isGreaterThanOrEqualTo: minPrice);
      }

      if (maxPrice != null) {
        queryRef = queryRef.where('Price', isLessThanOrEqualTo: maxPrice);
      }

      // Execute the query
      QuerySnapshot querySnapshot = await queryRef.get();

      // Map the documents to ProductModel objects
      final products = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();

      return products;
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw MyGeneralException().message;
    }
  }

  /// Update any field in specific Collection
  Future<void> updateSingleField(
      String docId, Map<String, dynamic> json) async {
    try {
      await _db.collection("Products").doc(docId).update(json);
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw MyFormatException();
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw MyGeneralException().message;
    }
  }

  /// Update product.
  Future<void> updateProduct(ProductModel product) async {
    try {
      await _db.collection('Products').doc(product.id).update(product.toJson());
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw MyFormatException();
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw MyGeneralException().message;
    }
  }
}
