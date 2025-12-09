import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:pizza_app/screens/cart/blocs/get_cart_bloc/get_cart_bloc.dart';

class CartIndicator extends StatefulWidget {
  const CartIndicator({super.key});

  @override
  State<CartIndicator> createState() => _CartIndicatorState();
}

class _CartIndicatorState extends State<CartIndicator> {
  @override
  void initState() {
    super.initState();
    // Trigger GetCart event after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = context.read<AuthenticationBloc>().state.user?.userId ?? '';
      if (userId.isNotEmpty) {
        context.read<GetCartBloc>().add(GetCart(userId));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCartBloc, GetCartState>(
      builder: (context, state) {
        int totalItems = 0;
        
        // Calculate total items if cart has items
        if (state is GetCartSuccess && state.carts.isNotEmpty) {
          totalItems = state.carts.fold(
            0,
            (sum, cart) => sum + cart.quantity,
          );
        }
        
        // Only show badge if there are items in cart
        if (totalItems > 0) {
          return Positioned(
            right: 5,
            top: 5,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Text(
                '$totalItems',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        
        // Return empty container if no items
        return const SizedBox.shrink();
      },
    );
  }
}
