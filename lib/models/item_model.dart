import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/rating_model.dart';

class ItemModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String? type;
  
  final List<RatingModel>? rating;

  ItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.rating,
    this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'rating': rating?.map((r) => r.toMap()).toList(),
      'type': type,
    };
  }

  factory ItemModel.fromDocument(DocumentSnapshot doc) {
    return ItemModel(
      id: doc.id,
      name: doc['name'],
      description: doc['description'],
      price: doc['price'].toDouble(),
      imageUrl: doc['imageUrl'],
      rating: doc['rating'] != null
          ? List<RatingModel>.from(
              doc['rating'].map((r) => RatingModel.fromDocument(r)))
          : null,
      type: doc['type'],
    );
  }
}
