import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String? id;
  final String invoice;
  final String coustomoer;
  final String datetime;

  CartModel({
    this.id,
    required this.invoice,
    required this.coustomoer,
    required this.datetime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'invoice': invoice,
      'coustomoer': coustomoer,
      'datetime': datetime,
    };
  }

  factory CartModel.fromDocument(DocumentSnapshot doc) {
    return CartModel(
      id: doc.id,
      invoice: doc['invoice'],
      coustomoer: doc['coustomoer'],
      datetime: doc['datetime'],
    );
  }
}
