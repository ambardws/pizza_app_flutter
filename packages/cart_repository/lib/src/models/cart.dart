import 'package:pizza_repository/pizza_repository.dart';

import '../entities/entities.dart';

class Cart {
  final String id;
  final int price;
  final int quantity;
  final Pizza pizza;

  Cart({
    required this.id,
    required this.pizza,
    required this.price,
    required this.quantity,
  });

  CartEntity toEntity() {
    return CartEntity(
      id: id,
      pizza: pizza,
      price: price,
      quantity: quantity,
    );
  }

  static Cart fromEntity(CartEntity entity) {
    return Cart(
      id: entity.id,
      pizza: entity.pizza,
      price: entity.price,
      quantity: entity.quantity,
    );
  }
}
