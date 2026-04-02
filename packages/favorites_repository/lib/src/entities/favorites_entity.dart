import 'package:pizza_repository/pizza_repository.dart';

class FavoritesEntity {
  final String id;
  final String userId;
  final Pizza pizza;

  FavoritesEntity({
    required this.id,
    required this.userId,
    required this.pizza,
  });

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'userId': userId,
      'pizza': pizza.toEntity().toDocument(), // Mengubah Pizza Object menjadi Map
    };
  }

  static FavoritesEntity fromDocument(Map<String, dynamic> doc) {
    return FavoritesEntity(
      id: doc['id'],
      userId: doc['userId'],
      pizza: Pizza.fromEntity(PizzaEntity.fromDocument(doc['pizza'])), // Merakit Map kembali menjadi Pizza Object
    );
  }
}
