import 'package:pizza_repository/pizza_repository.dart';

class CartEntity {
  final String id;
  final int price;
  final int quantity;
  final Pizza pizza;

  CartEntity({
    required this.id,
    required this.pizza,
    required this.price,
    required this.quantity,
  });

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'pizza': pizza.toEntity().toDocument(),
      'price': price,
      'quantity': quantity,
    };
  }

  static CartEntity fromDocument(Map<String, dynamic> doc) {
    return CartEntity(
      id: doc['id']
          .toString(), // Convert to String to handle both String and number
      pizza: Pizza.fromEntity(PizzaEntity.fromDocument(doc['pizza'])),
      price: (doc['price'] is int)
          ? doc['price']
          : (doc['price'] as num).toInt(), // Handle both int and double
      quantity: doc['quantity'],
    );
  }
}
