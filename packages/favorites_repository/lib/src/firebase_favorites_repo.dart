import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorites_repository/src/entities/entities.dart';
import 'package:favorites_repository/src/favorites_repo.dart';
import 'package:favorites_repository/src/models/models.dart';
import 'dart:developer';

class FirebaseFavoritesRepo implements FavoritesRepository {
  final favoritesCollection =
      FirebaseFirestore.instance.collection('favorites');

  @override
  Future<List<Favorites>> getFavorites(String userId) async {
    try {
      return await favoritesCollection
          .where('userId', isEqualTo: userId)
          .get()
          .then((value) => value.docs.map((e) {
                final data = e.data();
                data['id'] = e.id;
                return Favorites.fromEntity(FavoritesEntity.fromDocument(data));
              }).toList());
    } catch (e) {
      log('Error fetching favorites: $e');
      return [];
    }
  }

  @override
  Future<void> addFavorite(String userId, Favorites favorites) async {
    try {
      // check if favorite already exists
      final existingFavorites = await favoritesCollection
          .where('userId', isEqualTo: userId)
          .where('pizza.pizzaId', isEqualTo: favorites.pizza.pizzaId)
          .get();

      if (existingFavorites.docs.isNotEmpty) {
        // SET failure state
        throw Exception('Favorite already exists');
      }

      await favoritesCollection.add({
        'userId': userId,
        ...favorites.toEntity().toDocument(),
      });
    } catch (e) {
      log('Error adding favorite: $e');
      rethrow;
    }
  }

  @override
  Future<void> removeFavorite(String userId, String favoriteId) async {
    try {
      await favoritesCollection.doc(favoriteId).delete();
    } catch (e) {
      log('Error removing favorite: $e');
      return;
    }
  }
}
