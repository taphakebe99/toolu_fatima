import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String id;
  String? sku;
  double price;
  String title;
  DateTime? date;
  bool? isFeatured;
  String? categoryId;
  String? unityId;
  String? description;
  String image;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    this.sku,
    this.date,
    this.image = '',
    this.isFeatured,
    this.categoryId,
    this.unityId,
    this.description,
  });

  /// Create Empty func for clean code
  static ProductModel empty() => ProductModel(
        id: '',
        title: '',
        price: 0,
        image: '',
      );

  /// Json Format,
  toJson() {
    return {
      'Sku': sku,
      'Title': title,
      'Price': price,
      'Image': image,
      'IsFeatured': isFeatured,
      'CategoryId': categoryId,
      'UnityId': unityId,
      'Description': description,
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ProductModel(
      id: document.id,
      title: data['Title'],
      price: double.parse((data['Price'] ?? 0.0).toString()),
      sku: data['Sku'],
      isFeatured: data['IsFeatured'] ?? false,
      categoryId: data['CategoryId'] ?? '',
      unityId: data['UnityId'] ?? '',
      description: data['Description'] ?? '',
      image: data['Image'] ?? '',
    );
  }

  // Map Json-oriented document snapshot from Firebase to Model
  factory ProductModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return ProductModel(
      id: document.id,
      title: data['Title'] ?? '',
      price: double.parse((data['Price'] ?? 0.0).toString()),
      sku: data['Sku'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      categoryId: data['CategoryId'] ?? '',
      unityId: data['UnityId'] ?? '',
      description: data['Description'] ?? '',
      image: data['Image'] ?? '',
    );
  }
}
