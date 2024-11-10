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

  factory UserFavModel.fromMap(Map<String, dynamic> map) {
    return UserFavModel(
      id: map['id'],
      email: map['email'],
      favoriteIds: List<String>.from(map['favoriteIds'] ?? []),
    );
  }
}
