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
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(3, 3)),
        ],
        image: DecorationImage(image: NetworkImage(picture), fit: BoxFit.cover),
      ),
    );
  }
}
