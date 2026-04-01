import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/main_navigation/main_navigation.dart';

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
                ? _buildEmptyState(context, screenWidth, screenHeight)
                : _buildFavoritesList(
                  context,
                  screenWidth,
                  screenHeight,
                  favoritePizzas,
                ),
      ),
    );
  }

  /// Widget untuk state kosong (belum ada favorite)
  Widget _buildEmptyState(
    BuildContext context,
    double screenWidth,
    double screenHeight,
  ) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: screenWidth * 0.3,
              height: screenWidth * 0.3,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                CupertinoIcons.heart,
                size: screenWidth * 0.15,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Text(
              'No Favorites Yet',
              style: TextStyle(
                fontSize: screenWidth * 0.055,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.015),
            Text(
              'Start adding your favorite pizzas!\nTap the heart icon on any pizza.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                color: Theme.of(
                  context,
                ).colorScheme.onBackground.withOpacity(0.6),
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            ElevatedButton(
              onPressed: () {
                MainNavigation.switchTab(context, 0);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.08,
                  vertical: screenHeight * 0.02,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                'Browse Pizzas',
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget untuk list favorite pizzas
  Widget _buildFavoritesList(
    BuildContext context,
    double screenWidth,
    double screenHeight,
    List<Map<String, dynamic>> favoritePizzas,
  ) {
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
              return _buildFavoriteCard(context, screenWidth, pizza);
            }, childCount: favoritePizzas.length),
          ),
        ),
      ],
    );
  }

  /// Card untuk setiap favorite pizza
  Widget _buildFavoriteCard(
    BuildContext context,
    double screenWidth,
    Map<String, dynamic> pizza,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pizza Image
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Image.asset(
                    pizza['image'] ?? 'assets/1.png',
                    fit: BoxFit.contain,
                  ),
                ),
                // Remove favorite button
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        CupertinoIcons.heart_fill,
                        color: Colors.red,
                        size: screenWidth * 0.05,
                      ),
                      onPressed: () {
                        // TODO: Remove from favorites
                        debugPrint('Remove from favorites');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Pizza Info
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pizza['name'] ?? 'Pizza Name',
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: screenWidth * 0.01),
                Text(
                  '\$${pizza['price'] ?? '0.00'}',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
