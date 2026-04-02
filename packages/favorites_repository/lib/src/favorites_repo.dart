import 'models/models.dart';

abstract class FavoritesRepository {
  Future<List<Favorites>> getFavorites(String userId);

  Future<void> addFavorite(String userId, Favorites favorites);

  Future<void> removeFavorite(String userId, String favoriteId);
}
