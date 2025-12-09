import 'dart:developer';

import 'package:cart_repository/cart_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCartRepo implements CartRepository {
  final cartCollection = FirebaseFirestore.instance.collection('carts');

  Future<List<Cart>> getCarts(String userId) async {
    try {
      return await cartCollection.where('userId', isEqualTo: userId).get().then(
          (value) => value.docs
              .map((e) => Cart.fromEntity(CartEntity.fromDocument(e.data())))
              .toList());
    } catch (e) {
      log('Error fetching carts: $e');
      return [];
    }
  }

  Future<void> addCart(String userId, Cart cart) async {
    try {
      await cartCollection.add({
        'userId': userId,
        ...cart.toEntity().toDocument(),
      });
    } catch (e) {
      log('Error adding cart: $e');
      return;
    }
  }
}
