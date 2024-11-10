import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/address_model.dart';
import 'package:flutter_application_1/models/cart_model.dart';
import 'package:flutter_application_1/models/payment_model.dart';
import 'package:flutter_application_1/models/user_fav_model.dart';


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
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      displayName: data['displayName'],
      photoURL: data['photoURL'],
      address: data['address'] != null ? AddressModel.fromDocument(data['address']) : null,
      payment: data['payment'] != null ? PaymentModel.fromDocument(data['payment']) : null,
      favorites: data['favorites'] != null
          ? List<UserFavModel>.from(data['favorites'].map((x) => UserFavModel.fromDocument(x)))
          : null,
      cartItem: data['cartItem'] != null
          ? List<CartModel>.from(data['cartItem'].map((x) => CartModel.fromDocument(x)))
          : null,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      displayName: map['displayName'] ?? '',
      photoURL: map['photoURL'] ?? '',
      address: map['address'] != null ? AddressModel.fromMap(map['address']) : null,
      payment: map['payment'] != null ? PaymentModel.fromMap(map['payment']) : null,
      favorites: map['favorites'] != null
          ? List<UserFavModel>.from(map['favorites'].map((x) => UserFavModel.fromMap(x)))
          : null,
      cartItem: map['cartItem'] != null
          ? List<CartModel>.from(map['cartItem'].map((x) => CartModel.fromMap(x)))
          : null,
    );
  }
}
