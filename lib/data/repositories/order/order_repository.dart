import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/order_model.dart';
import '../authentication/authentication_repository.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /* ---------------------------- FUNCTIONS ---------------------------------*/

  /// Get all order related to current User
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = AuthenticationRepository.instance.getUserID;
      if (userId.isEmpty) {
        throw 'Impossible de trouver les informations de l\'utilisateur. Veuillez réessayer dans quelques minutes.';
      }

      final result = await _db
          .collection('Orders')
          .where('userId', isEqualTo: userId)
          .get();
      return result.docs
          .map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw 'Une erreur est survenue lors de la récupération des informations de commande. Veuillez réessayer plus tard.';
    }
  }

  /// Store new user order
  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      await _db.collection('Orders').add(order.toJson());
    } catch (e) {
      throw 'Une erreur est survenue lors de l\'enregistrement des informations de commande. Veuillez réessayer plus tard.';
    }
  }
}
