import 'package:flutter_application_1/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RatingModel {
  final String massege;
  final int rating;
  final UserModel user;

  RatingModel({
    required this.rating,
    required this.massege,
    required this.user,
  });

  Map<String, dynamic> toMap() {
    return {
      'rating': rating,
      'massege': massege,
      'user': user.toMap(),
    };
  }

  factory RatingModel.fromDocument(DocumentSnapshot doc) {
    return RatingModel(
      rating: doc['rating'],
      massege: doc['massege'],
      user: UserModel.fromDocument(doc['user']),
    );
  }
}
