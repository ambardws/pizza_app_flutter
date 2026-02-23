import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/screens/cart/blocs/get_cart_bloc/get_cart_bloc.dart';
import 'package:pizza_app/screens/cart/views/cart_screen.dart';
import 'package:pizza_app/screens/favorites/views/favorites_screen.dart';
import 'package:pizza_app/screens/home/views/home_screen.dart';
import 'package:pizza_app/screens/orders/views/orders_screen.dart';
import 'package:pizza_app/screens/profile/views/profile_screen.dart';

/// Main navigation widget dengan bottom navigation bar
/// Meng-handle 4 tabs utama: Home, Orders, Favorites, Profile
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  // Index tab yang aktif
  int _currentIndex = 0;

  // List screens untuk setiap tab
  final List<Widget> _screens = [
    const HomeScreen(),
    const OrdersScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  // Handle saat tab di-tap
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: _screens[_currentIndex],

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.grey.shade800,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            height: screenHeight * 0.08,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  icon: CupertinoIcons.house,
                  activeIcon: CupertinoIcons.house_fill,
                  label: 'Home',
                  index: 0,
                  screenWidth: screenWidth,
                ),
                _buildNavItem(
                  icon: CupertinoIcons.time,
                  activeIcon: CupertinoIcons.time_solid,
                  label: 'Orders',
                  index: 1,
                  screenWidth: screenWidth,
                ),
                _buildNavItem(
                  icon: CupertinoIcons.heart,
                  activeIcon: CupertinoIcons.heart_fill,
                  label: 'Favorites',
                  index: 2,
                  screenWidth: screenWidth,
                ),
                _buildNavItem(
                  icon: CupertinoIcons.person,
                  activeIcon: CupertinoIcons.person_fill,
                  label: 'Profile',
                  index: 3,
                  screenWidth: screenWidth,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Widget untuk setiap nav item
  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
    required double screenWidth,
  }) {
    final isActive = _currentIndex == index;
    final screenHeight = MediaQuery.of(context).size.height;

    return Expanded(
      child: InkWell(
        onTap: () => _onTabTapped(index),
        splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).brightness == Brightness.light
                      ? Colors.grey.shade600
                      : Colors.grey.shade400,
              size: screenWidth * 0.06,
            ),
            SizedBox(height: screenHeight * 0.004),
            Text(
              label,
              style: TextStyle(
                fontSize: screenWidth * 0.028,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade600
                        : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
