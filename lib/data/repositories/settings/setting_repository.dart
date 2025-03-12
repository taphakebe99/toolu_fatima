import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/personalization/models/setting_model.dart';
import '../../../utils/exceptions/my_firebase_auth_exception.dart';
import '../../../utils/exceptions/my_format_exception.dart';
import '../../../utils/exceptions/my_platform_exception.dart';

/// Repository class for setting-related operations.
class SettingsRepository extends GetxController {
  static SettingsRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to save setting data to Firestore.
  Future<void> registerSettings(SettingsModel setting) async {
    try {
      await _db
          .collection("Settings")
          .doc('GLOBAL_SETTINGS')
          .set(setting.toJson());
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw MyFormatException();
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw 'Une erreure est survenue. Veuilez réesseyez';
    }
  }

  /// Function to fetch setting details based on setting ID.
  Future<SettingsModel> getSettings() async {
    try {
      final querySnapshot =
          await _db.collection("Settings").doc('GLOBAL_SETTINGS').get();
      return SettingsModel.fromSnapshot(querySnapshot);
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw MyFormatException();
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('Something Went Wrong: $e');
      throw 'Une erreure est survenue: $e';
    }
  }

  /// Function to update setting data in Firestore.
  Future<void> updateSettingDetails(SettingsModel updatedSetting) async {
    try {
      await _db
          .collection("Settings")
          .doc('GLOBAL_SETTINGS')
          .update(updatedSetting.toJson());
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw MyFormatException();
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw 'Une erreure est survenue. Veuilez réesseyez';
    }
  }

  /// Update any field in specific Settings Collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db.collection("Settings").doc('GLOBAL_SETTINGS').update(json);
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw MyFormatException();
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw 'Une erreure est survenue. Veuilez réesseyez';
    }
  }
}
