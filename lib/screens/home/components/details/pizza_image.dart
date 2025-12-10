import 'package:flutter/material.dart';

class PizzaImage extends StatelessWidget {
  final String picture;

  const PizzaImage({super.key, required this.picture});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width - (40),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 5,
            offset: const Offset(3, 3),
          ),
        ],
        image: DecorationImage(image: NetworkImage(picture), fit: BoxFit.cover),
      ),
    );
  }
}
