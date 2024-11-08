import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  final String? id;
  final String cardNumber;
  final String expiryDate;
  final String cvv;

  PaymentModel({
    this.id,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'cvv': cvv,
    };
  }

  factory PaymentModel.fromDocument(DocumentSnapshot doc) {
    return PaymentModel(
      id: doc.id,
      cardNumber: doc['cardNumber'],
      expiryDate: doc['expiryDate'],
      cvv: doc['cvv'],
    );
  }
}
