import 'package:cloud_firestore/cloud_firestore.dart';

class UnityModel {
  String id;
  String unity;

  UnityModel({
    required this.id,
    required this.unity,
  });

  /// Empty Helper Function
  static UnityModel empty() => UnityModel(
        id: '',
        unity: '',
      );

  /// Convert model to Json structure so that you can store data in Firebase
  toJson() {
    return {
      'Unity': unity,
    };
  }

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory UnityModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      // Map JSON Record to the Model
      return UnityModel(
        id: document.id,
        unity: data['Unity'] ?? '',
      );
    } else {
      return UnityModel.empty();
    }
  }
}
