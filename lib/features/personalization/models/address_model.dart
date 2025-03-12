import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  String id;
  final String name;
  final String phoneNumber;
  final DateTime? dateTime;
  bool selectedAddress;

  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.dateTime,
    this.selectedAddress = true,
  });


  static AddressModel empty() => AddressModel(
        id: '',
        name: '',
        phoneNumber: '',
      );

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'PhoneNumber': phoneNumber,
      'DateTime': DateTime.now(),
      'SelectedAddress': selectedAddress,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> data) {
    return AddressModel(
      id: data['Id'] as String,
      name: data['Name'] as String,
      phoneNumber: data['PhoneNumber'] as String,
      selectedAddress: data['SelectedAddress'] as bool,
      dateTime: (data['DateTime'] as Timestamp).toDate(),
    );
  }

  // Factory constructor to create an AddressModel from a DocumentSnapshot
  factory AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return AddressModel(
      id: snapshot.id,
      name: data['Name'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      dateTime: (data['DateTime'] as Timestamp).toDate(),
      selectedAddress: data['SelectedAddress'] as bool,
    );
  }
}
