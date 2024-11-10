import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  final String id;
  final String? street;
  final String? city;
  final String? state;
  final String? zipCode;

  AddressModel({
    required this.id,
    this.street,
    this.city,
    this.state,
    this.zipCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'street': street,
      'city': city,
      'state': state,
      'zipCode': zipCode,
    };
  }

  factory AddressModel.fromDocument(DocumentSnapshot doc) {
    return AddressModel(
      id: doc.id,
      street: doc['street'],
      city: doc['city'],
      state: doc['state'],
      zipCode: doc['zipCode'],
    );
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] ?? '',
      street: map['street'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      zipCode: map['zipCode'] ?? '',
    );
  }
}
