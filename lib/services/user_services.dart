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
    DocumentSnapshot doc = await collection.doc(id).get();
    if (doc.exists) {
      return UserModel.fromDocument(doc);
    } else {
      return null;
    }
  }

  // UPDATE user
  Future<void> updateUser(UserModel user) async {
    await collection.doc(user.id).update(user.toMap());
  }

  // UPDATE specific fields
  Future<void> updateUserFields(String userId, Map<String, dynamic> fields) async {
    await collection.doc(userId).update(fields);
  }

  // DELETE user
  Future<void> deleteUser(String id) async {
    await collection.doc(id).delete();
  }
}