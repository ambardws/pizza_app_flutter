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
      'pizza': pizza,
    };
  }

  static FavoritesEntity fromDocument(Map<String, dynamic> doc) {
    return FavoritesEntity(
      id: doc['id'],
      userId: doc['userId'],
      pizza: doc['pizza'],
    );
  }
}
