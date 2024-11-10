import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String id;
  final String uid;
  final List<int> qty;  
  final List<String> cartItem;
  CartModel({
    required this.qty,
    required this.id,
    required this.uid,
    required this.cartItem,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'qty': qty,
      'cartItem': cartItem,
    };
  }

  factory CartModel.fromDocument(DocumentSnapshot doc) {
    return CartModel(
      id: doc.id,
      uid: doc['uid'],
      qty: List<int>.from(doc['qty']),
      cartItem: List<String>.from(doc['cartItem']),
    );
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'],
      uid: map['uid'],
      qty: List<int>.from(map['qty']),
      cartItem: List<String>.from(map['cartItem']),
    );
  }
}
