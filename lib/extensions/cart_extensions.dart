import 'package:cart_repository/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:pizza_app/screens/cart/blocs/add_cart_bloc/add_cart_bloc.dart';
import 'package:pizza_app/screens/cart/blocs/get_cart_bloc/get_cart_bloc.dart';
import 'package:pizza_repository/pizza_repository.dart';

/// Extension on BuildContext for cart-related operations
/// Provides easy access to cart actions throughout the app
extension CartContext on BuildContext {
  /// Get current user ID from AuthenticationBloc
  String get userId =>
      read<AuthenticationBloc>().state.user?.userId ?? '';

  /// Refresh cart data for current user
  void refreshCart() {
    if (userId.isNotEmpty) {
      read<GetCartBloc>().add(GetCart(userId));
    }
  }

  /// Add pizza to cart
  void addToCart(Pizza pizza) {
    final cart = Cart(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      pizza: pizza,
      price: pizza.price,
      quantity: 1,
    );

    read<AddCartBloc>().add(AddCart(cart, userId));
  }
}
