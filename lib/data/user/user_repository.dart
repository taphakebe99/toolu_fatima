import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../features/personalization/models/user_model.dart';
import '../../utils/exceptions/My_general_exception.dart';
import '../../utils/exceptions/my_firebase_exception.dart';
import '../../utils/exceptions/my_format_exception.dart';
import '../../utils/exceptions/my_platform_exception.dart';
import '../repositories/authentication/authentication_repository.dart';

/// Repository class for user-related operations.
class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _firebaseStorage = FirebaseStorage.instance;

  /// Function to save user data to Firestore.
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
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

  Future<UserModel?> getUserById(String userId) async {
    try {
      final documentSnapshot = await _db.collection('Users').doc(userId).get();

      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
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

  /// Function to fetch user details based on user ID.
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.getUserID)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
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

  /// Function to update user data in Firestore.
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db
          .collection("Users")
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
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

  /// Update any field in specific Users Collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.getUserID)
          .update(json);
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

  /// Upload any Image
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = _firebaseStorage.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
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

  /// Function to remove user data from Firestore.
  Future<void> removeUserRecord(String userId) async {
    try {
      // Référence aux collections
      final userRef = _db.collection("Users").doc(userId);
      final ordersRef =
          _db.collection("Orders").where("userId", isEqualTo: userId);
      final addressesRef = userRef.collection("Addresses");

      // Supprimer les commandes associées
      final ordersSnapshot = await ordersRef.get();
      for (var order in ordersSnapshot.docs) {
        await order.reference.delete();
      }

      // Supprimer toutes les adresses associées (collection)
      final addressesSnapshot = await addressesRef.get();
      for (var address in addressesSnapshot.docs) {
        await address.reference.delete();
      }

      // Supprimer l'utilisateur
      await userRef.delete();
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
