import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/user_model.dart';

class UserServices {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('user');

  // ADD data
  Future<void> addUser(UserModel user) async {
    await collection.doc(user.id).set(user.toMap());
  }

  // GET all data
  Future<List<UserModel>> getAllUsers() async {
    QuerySnapshot querySnapshot = await collection.get();
    return querySnapshot.docs.map((doc) {
      return UserModel.fromDocument(doc);
    }).toList();
  }

  // GET single data
  Future<UserModel?> getSingleUser(String id) async {
    try {
      DocumentSnapshot doc = await collection.doc(id).get();
      if (doc.exists) {
        return UserModel.fromDocument(doc);
      }
      return null;
    } catch (e) {
      print(e);
    return null;
    }
  }

  // UPDATE user
  Future<void> updateUser(UserModel user) async {
    await collection.doc(user.id).update(user.toMap());
  }

  // UPDATE specific fields
  Future<void> updateUserFields(
      String userId, Map<String, dynamic> fields) async {
    await collection.doc(userId).update(fields);
  }

  // DELETE specific fields
  Future<void> deleteUserFields(
      String userId, Map<String, dynamic> fields) async {
    await collection.doc(userId).update(fields);
  }

  // DELETE user
  Future<void> deleteUser(String id) async {
    await collection.doc(id).delete();
  }

  // Add to favorites list
  Future<void> addToFavorites(String userId, String itemId) async {
    await collection.doc(userId).update({
      'favorites': FieldValue.arrayUnion([itemId])
    });
  }

  // Remove from favorites list
  Future<void> removeFromFavorites(String userId, String itemId) async {
    await collection.doc(userId).update({
      'favorites': FieldValue.arrayRemove([itemId])
    });
  }

  // Get user's favorites
  Future<List<String>> getUserFavorites(String userId) async {
    DocumentSnapshot doc = await collection.doc(userId).get();
    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      return List<String>.from(data['favorites'] ?? []);
    }
    return [];
  }

  // Check if item is in user's favorites
  Future<bool> isItemFavorite(String userId, String itemId) async {
    try {
      DocumentSnapshot doc = await collection.doc(userId).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        final favorites = List<String>.from(data['favorites'] ?? []);
        return favorites.contains(itemId) ? true : false;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
