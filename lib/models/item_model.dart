import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  ItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  factory ItemModel.fromDocument(DocumentSnapshot doc) {
    return ItemModel(
      id: doc.id,
      name: doc['name'],
      description: doc['description'],
      price: doc['price'],
      imageUrl: doc['imageUrl'],
    );
  }
}