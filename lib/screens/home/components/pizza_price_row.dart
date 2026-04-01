import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_repository/pizza_repository.dart';

class PizzaPriceRow extends StatelessWidget {
  final Pizza pizza;
  final double screenWidth;
  final VoidCallback onAddToCart;

  const PizzaPriceRow({
    super.key,
    required this.pizza,
    required this.screenWidth,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                pizza.discount > 0
                    ? '\$${(pizza.price * (1 - pizza.discount / 100)).toStringAsFixed(2)}'
                    : '\$${pizza.price}',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: screenWidth * 0.050,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              if (pizza.discount > 0) ...[
                SizedBox(width: screenWidth * 0.015),
                Text(
                  '\$${pizza.price}',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: screenWidth * 0.025,
                    color: Colors.grey.shade700,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ],
          ),
        ),
        Container(
          width: screenWidth * 0.07,
          height: screenWidth * 0.07,
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: onAddToCart,
            icon: Icon(
              CupertinoIcons.plus,
              color: Colors.white,
              size: screenWidth * 0.04,
            ),
          ),
        ),
      ],
    );
  }
}
