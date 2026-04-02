import 'package:favorites_repository/src/entities/favorites_entity.dart';
import 'package:pizza_repository/pizza_repository.dart';

class Favorites {
  final String id;
  final String userId;
  final Pizza pizza;

  Favorites({
    required this.id,
    required this.userId,
    required this.pizza,
  });

  FavoritesEntity toEntity() {
    return FavoritesEntity(
      id: id,
      userId: userId,
      pizza: pizza,
    );
  }

  static Favorites fromEntity(FavoritesEntity entity) {
    return Favorites(
      id: entity.id,
      userId: entity.userId,
      pizza: entity.pizza,
    );
  }
}
