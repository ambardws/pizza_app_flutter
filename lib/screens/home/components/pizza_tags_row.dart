import 'package:flutter/material.dart';
import 'package:pizza_repository/pizza_repository.dart';

class PizzaTagsRow extends StatelessWidget {
  final Pizza pizza;
  final double screenWidth;
  final double screenHeight;

  const PizzaTagsRow({
    super.key,
    required this.pizza,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.025,
      child: Row(
        children: [
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color:
                    pizza.isVeg
                        ? Colors.green.withOpacity(0.2)
                        : Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.015,
                  vertical: screenHeight * 0.002,
                ),
                child: Text(
                  pizza.isVeg ? 'VEG' : 'NON-VEG',
                  style: TextStyle(
                    color: pizza.isVeg ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.022,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.008),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.015,
                  vertical: screenHeight * 0.002,
                ),
                child: Text(
                  pizza.spicy > 5 ? '🌶️ SPICY' : '🌶️ BALANCE',
                  style: TextStyle(
                    color: pizza.spicy > 5 ? Colors.red : Colors.green,
                    fontWeight: FontWeight.w800,
                    fontSize: screenWidth * 0.02,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
