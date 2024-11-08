import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_app/models/address_model.dart';
import 'package:login_app/models/cart_model.dart';
import 'package:login_app/models/payment_model.dart';
import 'package:login_app/models/user_fav_model.dart';

class UserModel {
  final String id;
  
  final String? displayName;
  final String? photoURL;
  final AddressModel? address;
  final PaymentModel? payment;
  final List<UserFavModel>? favorites;
  final List<CartModel>? cartItem;

  UserModel({
    required this.id,
    
    this.displayName,
    this.photoURL,
    this.address,
    this.payment,
    this.favorites,
    this.cartItem,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      
      'displayName': displayName,
      'photoURL': photoURL,
      'address': address?.toMap(),
      'payment': payment?.toMap(),
      'favorites': favorites?.map((fav) => fav.toMap()).toList(),
      'cartItem': cartItem?.map((item) => item.toMap()).toList(),
    };
  }

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      id: doc.id,
      
      displayName: doc['displayName'],
      photoURL: doc['photoURL'],
      address: doc['address'] != null ? AddressModel.fromDocument(doc['address']) : null,
      payment: doc['payment'] != null ? PaymentModel.fromDocument(doc['payment']) : null,
      favorites: doc['favorites'] != null
          ? List<UserFavModel>.from(doc['favorites'].map((x) => UserFavModel.fromDocument(x)))
          : null,
      cartItem: doc['cartItem'] != null
          ? List<CartModel>.from(doc['cartItem'].map((x) => CartModel.fromDocument(x)))
          : null,
    );
  }
}
