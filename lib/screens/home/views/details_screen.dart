import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/screens/cart/blocs/add_cart_bloc/add_cart_bloc.dart';
import 'package:pizza_app/screens/home/components/details/add_to_cart_button.dart';
import 'package:pizza_app/screens/home/components/details/pizza_image.dart';
import 'package:pizza_app/screens/home/components/details/pizza_info.dart';
import 'package:cart_repository/cart_repository.dart';
import 'package:pizza_repository/src/models/pizza.dart';

class DetailsScreen extends StatelessWidget {
  final Pizza pizza;
  final String userId;

  const DetailsScreen(this.pizza, this.userId, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCartBloc(context.read<CartRepository>()),
      child: BlocListener<AddCartBloc, AddCartState>(
        listener: (context, state) {
          if (state is AddCartSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: const [
                    Icon(Icons.check_circle, color: Colors.white),
                    SizedBox(width: 12),
                    Text('Pizza add to cart successfully'),
                  ],
                ),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                PizzaImage(picture: pizza.picture),
                const SizedBox(height: 30),
                PizzaInfo(pizza: pizza),
                const SizedBox(height: 40),
                AddToCartButton(pizza: pizza, userId: userId),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
