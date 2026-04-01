import 'package:flutter/material.dart';
import 'package:pizza_app/screens/favorites/components/favorites_card.dart';

class FavoritesList extends StatelessWidget {
  const FavoritesList({
    super.key,
    required this.context,
    required this.screenWidth,
    required this.screenHeight,
    required this.favoritePizzas,
  });

  final BuildContext context;
  final double screenWidth;
  final double screenHeight;
  final List<Map<String, dynamic>> favoritePizzas;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Header
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Text(
              'My Favorites',
              style: TextStyle(
                fontSize: screenWidth * 0.07,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),

        // Grid pizza favorit
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: screenWidth * 0.03,
              mainAxisSpacing: screenHeight * 0.02,
              childAspectRatio: 0.75,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final pizza = favoritePizzas[index];
              return FavoritesCard(
                context: context,
                screenWidth: screenWidth,
                pizza: pizza,
              );
            }, childCount: favoritePizzas.length),
          ),
        ),
      ],
    );
  }
}
