import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/constants/enums.dart';
import '../../../utils/formatters/formatter.dart';
import '../../shop/models/cart_model.dart';
import 'address_model.dart';

/// Model class representing user data.
class UserModel {
  final String id;
  String fullName;
  final String? email;
  String phoneNumber;
  String profilePicture;
  final CartModel? cart;
  final List<AddressModel>? addresses;
  AppRole role;
  DateTime? createdAt;
  DateTime? updatedAt;

  /// Constructor for UserModel.
  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    this.cart,
    this.addresses,
    this.role = AppRole.user,
    this.createdAt,
    this.updatedAt,
  });

  /// Helper function to format phone number.
  String get formattedPhoneNo => MyFormatter.formatPhoneNumber(phoneNumber);

  /// Static function to create an empty user model.
  static UserModel empty() => UserModel(
      id: '', fullName: '', email: '', phoneNumber: '', profilePicture: '');

  /// Convert model to JSON structure for storing data in Firebase.
  Map<String, dynamic> toJson() {
    return {
      'FullName': fullName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
      'Role': AppRole.user.name,
      'CreatedAt': createdAt = DateTime.now(),
      'UpdatedAt': DateTime.now(),
    };
  }

  /// Factory method to create a UserModel from a Firebase document snapshot.
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        fullName: data['FullName'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }
}
