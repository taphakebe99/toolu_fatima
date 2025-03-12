import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../features/personalization/models/address_model.dart';
import '../authentication/authentication_repository.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /* ---------------------------- FUNCTIONS ---------------------------------*/

  /// Get all order related to current User
  Future<List<AddressModel>> fetchUserAddresses() async {
    try {
      final userId = AuthenticationRepository.instance.firebaseUser!.uid;
      if (userId.isEmpty) {
        throw 'Impossible de trouver les informations de l\'utilisateur. Réessayez dans quelques minutes.';
      }

      final result = await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .get();
      return result.docs
          .map((documentSnapshot) =>
              AddressModel.fromDocumentSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      // log e.toString();
      throw 'Une erreur est survenue lors de la récupération des informations d\'adresse. Veuillez réessayer plus tard.';
    }
  }

  /// Store new user order
  Future<String> addAddress(AddressModel address, String userId) async {
    try {
      final currentAddress = await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .add(address.toJson());
      return currentAddress.id;
    } catch (e) {
      throw 'Une erreur est survenue lors de l\'enregistrement de l\'adresse. Veuillez réessayer plus tard.';
    }
  }

  /// Update user address
  Future<void> updateAddress(AddressModel address, String userId) async {
    try {
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(address.id)
          .update(address.toJson());
    } catch (e) {
      throw 'Une erreur est survenue lors de la mise à jour de l\'adresse. Veuillez réessayer plus tard.';
    }
  }

  /// Clear the "selected" field for all addresses
  Future<void> updateSelectedField(
      String userId, String addressId, bool selected) async {
    try {
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(addressId)
          .update({'SelectedAddress': selected});
    } catch (e) {
      throw 'Impossible de mettre à jour votre sélection d\'adresse. Veuillez réessayer plus tard.';
    }
  }

  Future<void> deleteAddress(String userId, String addressId) async {
    try {
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(addressId)
          .delete();
    } catch (e) {
      throw 'Une erreur est survenue lors de la suppression de l\'adresse. Veuillez réessayer plus tard.';
    }
  }
}
