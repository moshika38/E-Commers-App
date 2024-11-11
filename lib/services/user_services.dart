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

  // UPDATE specific fields
  Future<void> updateUserFields(
      String userId, Map<String, dynamic> fields) async {
    await collection.doc(userId).update(fields);
  }

  // favorites

  // Favorites collection reference
  final CollectionReference favoritesCollection =
      FirebaseFirestore.instance.collection('favorites');

  // Add to favorites list
  Future<void> addToFavorites(String userId, String itemId) async {
    DocumentSnapshot favDoc = await favoritesCollection.doc(userId).get();

    if (!favDoc.exists) {
      // Create new favorites document if it doesn't exist
      await favoritesCollection.doc(userId).set({
        'userId': userId,
        'favorites': [itemId]
      });
    } else {
      // Add to existing favorites
      await favoritesCollection.doc(userId).update({
        'favorites': FieldValue.arrayUnion([itemId])
      });
    }
  }

  // Remove from favorites list
  Future<void> removeFromFavorites(String userId, String itemId) async {
    await favoritesCollection.doc(userId).update({
      'favorites': FieldValue.arrayRemove([itemId])
    });
  }

  // Get user's favorites
  Future<List<String>> getUserFavorites(String userId) async {
    DocumentSnapshot doc = await favoritesCollection.doc(userId).get();
    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      return List<String>.from(data['favorites'] ?? []);
    }
    return [];
  }

  // Check if item is in user's favorites
  Future<bool> isItemFavorite(String userId, String itemId) async {
    try {
      DocumentSnapshot doc = await favoritesCollection.doc(userId).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        final favorites = List<String>.from(data['favorites'] ?? []);
        return favorites.contains(itemId);
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // cart

  // Cart collection reference
  final CollectionReference cartCollection =
      FirebaseFirestore.instance.collection('carts');

  // Add to cart list
  Future<void> addToCart(String userId, String itemId, int quantity) async {
    DocumentSnapshot cartDoc = await cartCollection.doc(userId).get();

    if (!cartDoc.exists) {
      // Create new cart document if it doesn't exist
      CartModel newCart = CartModel(
        id: userId,
        uid: userId,
        qty: [quantity], // Initialize with list containing quantity
        cartItem: [itemId],
      );
      await cartCollection.doc(userId).set(newCart.toMap());
    } else {
      // Add to existing cart
      CartModel existingCart = CartModel.fromDocument(cartDoc);
      List<String> currentItems = existingCart.cartItem;
      List<int> currentQty = existingCart.qty;

      if (!currentItems.contains(itemId)) {
        currentItems.add(itemId);
        currentQty.add(quantity);
        await cartCollection
            .doc(userId)
            .update({'cartItem': currentItems, 'qty': currentQty});
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

  Future<List<int>> getCartQuantities(String uid) async {
    try {
      DocumentSnapshot doc = await cartCollection.doc(uid).get();
      if (doc.exists) {
        CartModel cart = CartModel.fromDocument(doc);
        return cart.qty;
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> updateCartItemQty(String uid, int index, int newQty) async {
    try {
      DocumentSnapshot doc = await cartCollection.doc(uid).get();
      if (doc.exists) {
        CartModel cart = CartModel.fromDocument(doc);
        List<int> updatedQty = List<int>.from(cart.qty);

        if (index >= 0 && index < updatedQty.length) {
          updatedQty[index] = newQty;

          await cartCollection.doc(uid).update({'qty': updatedQty});
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> removeCartItem(String uid, int index) async {
    try {
      DocumentSnapshot doc = await cartCollection.doc(uid).get();
      if (doc.exists) {
        CartModel cart = CartModel.fromDocument(doc);
        List<String> updatedCartItems = List<String>.from(cart.cartItem);
        List<int> updatedQty = List<int>.from(cart.qty);

        if (index >= 0 && index < updatedCartItems.length) {
          updatedCartItems.removeAt(index);
          updatedQty.removeAt(index);

          await cartCollection.doc(uid).update({
            'cartItem': updatedCartItems,
            'qty': updatedQty,
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
