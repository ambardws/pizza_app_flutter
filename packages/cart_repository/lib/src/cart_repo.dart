import 'models/models.dart';

abstract class CartRepository {
  Future<List<Cart>> getCarts(String userId);

  Future<void> addCart(String userId, Cart cart);

  Future<void> updateCartQuantity(
      String userId, String cartId, int newQuantity);
}
