import 'package:cart_repository/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:pizza_app/screens/cart/blocs/get_cart_bloc/get_cart_bloc.dart';
import 'package:pizza_app/screens/cart/components/cart_item.dart';
import 'package:pizza_app/screens/cart/components/order_info.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch cart data when screen is first loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId =
          context.read<AuthenticationBloc>().state.user?.userId ?? '';
      if (userId.isNotEmpty) {
        context.read<GetCartBloc>().add(GetCart(userId));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Cart'))),
      body: BlocBuilder<GetCartBloc, GetCartState>(
        builder: (context, state) {
          if (state is GetCartProcess) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetCartSuccess) {
            return _buildCartContent(state.carts);
          } else if (state is GetCartFailure) {
            return const Center(child: Text('Failed to load cart'));
          } else {
            return const Center(child: Text('Your cart is empty'));
          }
        },
      ),
    );
  }

  Widget _buildCartContent(List<Cart> carts) {
    if (carts.isEmpty) {
      return const Center(child: Text('Your cart is empty'));
    }

    // Calculate totals
    double subTotal = carts.fold(
      0,
      (sum, cart) => sum + cart.price * cart.quantity,
    );
    double delivery = 2.00;
    double total = subTotal + delivery;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: carts.length,
            itemBuilder: (context, index) {
              return CartItem(cart: carts[index]);
            },
          ),
        ),
        OrderInfo(subTotal: subTotal, delivery: delivery, total: total),
      ],
    );
  }
}
