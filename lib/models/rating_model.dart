import 'package:cloud_firestore/cloud_firestore.dart';

class RatingModel {
  final String itemName;
  final String massage;
  final double rating;
  final String user;

  RatingModel({
    required this.itemName,   
    required this.rating,
    required this.massage,
    required this.user,
  });

  Map<String, dynamic> toMap() {
    return {
      'itemName': itemName,
      'rating': rating,
      'massege': massage,
      'user': user,
    };
  }

  factory RatingModel.fromDocument(DocumentSnapshot doc) {
    return RatingModel(
      itemName: doc['itemName'],
      rating: doc['rating'],
      massage: doc['massege'],
      user: doc['user'],
    );
  }
}
