import 'package:cloud_firestore/cloud_firestore.dart';

class UserFavModel {
  final String id;
  final String email;
  final List<String> favoriteIds;

  UserFavModel({
    required this.id,
    required this.email,
    required this.favoriteIds,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'favoriteIds': favoriteIds,
    };
  }

  factory UserFavModel.fromDocument(DocumentSnapshot doc) {
    return UserFavModel(
      id: doc.id,
      email: doc['email'],
      favoriteIds: List<String>.from(doc['favoriteIds'] ?? []),
    );
  }
}
