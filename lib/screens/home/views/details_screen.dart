import 'package:flutter/material.dart';
import 'package:pizza_app/screens/home/components/details/add_to_cart_button.dart';
import 'package:pizza_app/screens/home/components/details/pizza_image.dart';
import 'package:pizza_app/screens/home/components/details/pizza_info.dart';
import 'package:pizza_repository/src/models/pizza.dart';

class DetailsScreen extends StatelessWidget {
  final Pizza pizza;
  final String userId;

  const DetailsScreen(this.pizza, this.userId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.background),
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
    );
  }
}
