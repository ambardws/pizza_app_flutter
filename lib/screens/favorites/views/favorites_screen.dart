import 'package:flutter/material.dart';
import 'package:pizza_app/screens/favorites/components/empty_favorites.dart';
import 'package:pizza_app/screens/favorites/components/favorites_list.dart';

/// Favorites screen - menampilkan pizza favorit user
/// TODO: Integrate dengan favorite BLoC
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Placeholder data - nanti diganti dengan real data dari BLoC
    final List<Map<String, dynamic>> favoritePizzas = [];

    return Scaffold(
      body: SafeArea(
        child:
            favoritePizzas.isEmpty
                ? EmptyFavorites(
                  context: context,
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                )
                : FavoritesList(
                  context: context,
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  favoritePizzas: favoritePizzas,
                ),
      ),
    );
  }
}
