import 'package:cart_repository/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/screens/cart/blocs/add_cart_bloc/add_cart_bloc.dart';
import 'package:pizza_repository/pizza_repository.dart';

class AddToCartButton extends StatelessWidget {
  final Pizza pizza;
  final String userId;

  const AddToCartButton({super.key, required this.pizza, required this.userId});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 3,
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          final cart = Cart(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            pizza: pizza,
            quantity: 1,
            price: pizza.price,
          );

          context.read<AddCartBloc>().add(AddCart(cart, userId));
        },
        child: const Text(
          'Add to Cart',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
