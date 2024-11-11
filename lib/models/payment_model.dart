import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  final String? id;
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  final String holderName ;

  PaymentModel({
    this.id,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    required this.holderName ,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'holderName ': holderName ,
      'cvv': cvv,
    };
  }

  factory PaymentModel.fromDocument(DocumentSnapshot doc) {
    return PaymentModel(
      id: doc.id,
      cardNumber: doc['cardNumber'],
      expiryDate: doc['expiryDate'],
      holderName : doc['holderName '],
      cvv: doc['cvv'],
    );
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      id: map['id'],
      cardNumber: map['cardNumber'],
      expiryDate: map['expiryDate'],
      holderName : map['holderName '],
      cvv: map['cvv'],
    );
  }
}
