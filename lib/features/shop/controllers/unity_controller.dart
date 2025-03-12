import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../data/unities/unity_repository.dart';
import '../../../utils/exceptions/my_firebase_auth_exception.dart';
import '../../../utils/exceptions/my_firebase_exception.dart';
import '../../../utils/exceptions/my_format_exception.dart';
import '../../../utils/exceptions/my_platform_exception.dart';
import '../../../utils/popups/loaders.dart';
import '../models/unity_model.dart';

class UnityController extends GetxController {
  static UnityController get instance => Get.find();

  // Firestore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final _unityRepository = Get.put(UnityRepository());
  RxList<UnityModel> allUnities = <UnityModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    fetchUnities();
    super.onInit();
  }

  /// Fetches allUnities  from Firestore
  Future<void> fetchUnities() async {
    try {
      isLoading.value = true;
      final unities = await _unityRepository.getAllUnities();

      // update category list
      allUnities.assignAll(unities);
    } catch (e) {
      MyLoaders.errorSnackBar(title: 'Oups!!!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetch a specific unit by ID
  Future<UnityModel?> fetchUnitById(String id) async {
    try {
      isLoading.value = true;
      final unity = await _unityRepository.getUnitById(id);
      return unity;
    } catch (e) {
      MyLoaders.errorSnackBar(title: 'Error', message: e.toString());
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> uploadDummyData(List<UnityModel> unities) async {
    try {
      for (var unity in unities) {
        await _db.collection('Unities').doc(unity.id).set(unity.toJson());
      }
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw MyFormatException().message;
    } catch (e) {
      throw 'something went wrong ${e.toString()}'; //MyGeneralException();
    }
  }
}
