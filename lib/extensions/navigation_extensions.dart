import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:pizza_app/screens/cart/views/cart_screen.dart';
import 'package:pizza_app/screens/home/views/details_screen.dart';
import 'package:pizza_repository/pizza_repository.dart';

/// Extension on BuildContext for navigation operations
/// Provides easy navigation methods throughout the app
extension NavigationContext on BuildContext {
  /// Navigate to pizza details screen
  void navigateToDetails(Pizza pizza, String userId) {
    Navigator.push(
      this,
      MaterialPageRoute(
        builder: (context) => DetailsScreen(pizza, userId),
      ),
    );
  }

  /// Navigate to cart screen
  void navigateToCart() {
    Navigator.push(
      this,
      MaterialPageRoute(
        builder: (context) => const CartScreen(),
      ),
    );
  }

  /// Show sign out confirmation dialog
  void showSignOutDialog() {
    final bloc = read<SignInBloc>();
    showDialog(
      context: this,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text(
          'Are you sure you want to sign out?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              bloc.add(SignOutRequired());
            },
            child: const Text(
              'Sign Out',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
