import 'package:flutter/material.dart';

import 'package:pizza_app/screens/home/components/pizza_price_row.dart';
import 'package:pizza_app/screens/home/components/pizza_tags_row.dart';
import 'package:pizza_repository/pizza_repository.dart';

class PizzaGridItem extends StatelessWidget {
  final Pizza pizza;
  final double screenWidth;
  final double screenHeight;
  final VoidCallback onAddToCart;
  final VoidCallback? onTap;

  const PizzaGridItem({
    super.key,
    required this.pizza,
    required this.screenWidth,
    required this.screenHeight,
    required this.onAddToCart,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    pizza.picture,
                    width: screenWidth * 0.35,
                    height: screenHeight * 0.15,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.025),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PizzaTagsRow(
                      pizza: pizza,
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    Text(
                      pizza.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: screenWidth * 0.032,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      pizza.description,
                      style: TextStyle(
                        color: Theme.of(
                          context,
                        ).colorScheme.onBackground.withOpacity(0.7),
                        fontSize: screenWidth * 0.025,
                        fontWeight: FontWeight.w300,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    PizzaPriceRow(
                      pizza: pizza,
                      screenWidth: screenWidth,
                      onAddToCart: onAddToCart,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
