import 'dart:developer';

import 'package:cart_repository/cart_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCartRepo implements CartRepository {
  final cartCollection = FirebaseFirestore.instance.collection('carts');

  Future<List<Cart>> getCarts(String userId) async {
    try {
      return await cartCollection
          .where('userId', isEqualTo: userId)
          .get()
          .then((value) => value.docs.map((e) {
                final data = e.data();
                data['id'] = e.id;
                return Cart.fromEntity(CartEntity.fromDocument(data));
              }).toList());
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

  Future<void> updateCartQuantity(
      String userId, String cartId, int newQuantity) async {
    try {
      await cartCollection.doc(cartId).update({'quantity': newQuantity});
    } catch (e) {
      log('Error updating cart quantity: $e');
      return;
    }
  }

  Future<void> removeCart(String cartId, String userId) async {
    try {
      await cartCollection.doc(cartId).delete();
    } catch (e) {
      log('Error removing cart: $e');
      return;
    }
  }
}
