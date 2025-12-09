import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/screens/cart/blocs/get_cart_bloc/get_cart_bloc.dart';

class CartBadgeWidget extends StatelessWidget {
  final VoidCallback? onTap;

  const CartBadgeWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCartBloc, GetCartState>(
      builder: (context, state) {
        int totalItems = 0;

        // Calculate total items if cart has items
        if (state is GetCartSuccess && state.carts.isNotEmpty) {
          totalItems = state.carts.fold(0, (sum, cart) => sum + cart.quantity);
        }

        return Stack(
          children: [
            IconButton(
              onPressed: onTap ?? () {},
              icon: const Icon(CupertinoIcons.cart),
            ),
            // Only show badge if there are items in cart
            if (totalItems > 0)
              Positioned(
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
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
