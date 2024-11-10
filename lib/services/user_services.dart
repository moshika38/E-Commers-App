import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/cart_model.dart';
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

  // favorites

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

  // card

  // Cart collection reference
  final CollectionReference cartCollection = FirebaseFirestore.instance.collection('carts');

  // Add to cart list
  Future<void> addToCart(String userId, String itemId, int uid) async {
    DocumentSnapshot cartDoc = await cartCollection.doc(userId).get();
    
    if (!cartDoc.exists) {
      // Create new cart document if it doesn't exist
      CartModel newCart = CartModel(
        id: userId,
        uid: userId,
        qty: uid,
        cartItem: [itemId],
      );
      await cartCollection.doc(userId).set(newCart.toMap());
    } else {
      // Add to existing cart
      CartModel existingCart = CartModel.fromDocument(cartDoc);
      List<String> currentItems = existingCart.cartItem;
      if (!currentItems.contains(itemId)) {
        currentItems.add(itemId);
        await cartCollection.doc(userId).update({
          'cartItem': currentItems,
          'qty': (existingCart.qty ?? 0) + 1
        });
      }
    }
  }

  // Update cart item quantity
  Future<void> updateCartItemQuantity(String userId, String itemName, int newQuantity) async {
    try {
      DocumentSnapshot cartDoc = await cartCollection.doc(userId).get();
      if (cartDoc.exists) {
        await cartCollection.doc(userId).update({
          'qty': newQuantity
        });
      }
    } catch (e) {
      print('Error updating cart item quantity: $e');
    }
  }

  // Remove from cart list
  Future<void> removeFromCart(String userId, String itemId) async {
    DocumentSnapshot cartDoc = await cartCollection.doc(userId).get();
    if (cartDoc.exists) {
      CartModel cart = CartModel.fromDocument(cartDoc);
      List<String> currentItems = cart.cartItem;
      if (currentItems.contains(itemId)) {
        currentItems.remove(itemId);
        await cartCollection.doc(userId).update({
          'cartItem': currentItems,
          'qty': (cart.qty ?? 1) > 0 ? (cart.qty ?? 1) - 1 : 0
        });
      }
    }
  }

  // Get user's cart
  Future<CartModel?> getUserCart(String userId) async {
    try {
      DocumentSnapshot doc = await cartCollection.doc(userId).get();
      if (doc.exists) {
        return CartModel.fromDocument(doc);
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Check if item is in user's cart 
  Future<bool> isItemInCart(String userId, String itemId) async {
    try {
      DocumentSnapshot doc = await cartCollection.doc(userId).get();
      if (doc.exists) {
        CartModel cart = CartModel.fromDocument(doc);
        return cart.cartItem.contains(itemId);
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
