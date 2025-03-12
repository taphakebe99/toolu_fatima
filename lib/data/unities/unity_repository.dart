import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../features/shop/models/unity_model.dart';
import '../../utils/exceptions/My_general_exception.dart';
import '../../utils/exceptions/my_firebase_exception.dart';
import '../../utils/exceptions/my_format_exception.dart';
import '../../utils/exceptions/my_platform_exception.dart';

class UnityRepository extends GetxController {
  // Singleton instance access using GetX
  static UnityRepository get instance => Get.find();

  // Firestore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<UnityModel>> getAllUnities() async {
    try {
      final documentSnapshot = await _db.collection('Unities').get();

      final list = documentSnapshot.docs
          .map((doc) => UnityModel.fromSnapshot(doc))
          .toList();

      return list;
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw MyFormatException().message;
    } catch (e) {
      throw MyGeneralException().message;
    }
  }

  /// Fetch a specific unit by its ID
  Future<UnityModel?> getUnitById(String id) async {
    try {
      final docSnapshot = await _db.collection('Unities').doc(id).get();
      if (docSnapshot.exists) {
        return UnityModel.fromSnapshot(docSnapshot);
      } else {
        throw 'Unity with ID $id not found';
      }
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw MyFormatException().message;
    } catch (e) {
      throw MyGeneralException().message;
    }
  }

}
