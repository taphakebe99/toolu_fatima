import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/category_model.dart';
import '../../../utils/exceptions/My_general_exception.dart';
import '../../../utils/exceptions/my_firebase_exception.dart';
import '../../../utils/exceptions/my_platform_exception.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /* ---------------------------- FUNCTIONS ---------------------------------*/

  /// Get all categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection("Categories").get();
      final result =
          snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw MyGeneralException().message;
    }
  }

  /// Get Featured categories
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final snapshot = await _db
          .collection("Categories")
          .where('ParentId', isEqualTo: categoryId)
          .get();
      final result =
          snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw MyGeneralException().message;
    }
  }

}
