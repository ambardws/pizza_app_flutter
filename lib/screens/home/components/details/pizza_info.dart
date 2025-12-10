import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizza_app/components/macro.dart';
import 'package:pizza_repository/pizza_repository.dart';

class PizzaInfo extends StatelessWidget {
  final Pizza pizza;

  const PizzaInfo({super.key, required this.pizza});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 5,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    pizza.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          pizza.discount > 0
                              ? '\$${(pizza.price - (pizza.price * pizza.discount / 100)).toStringAsFixed(2)}'
                              : '\$${pizza.price}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context)
                                    .colorScheme
                                    .primary, // Primary color usually good for price
                          ),
                        ),
                        if (pizza.discount > 0) ...[
                          Text(
                            '\$${pizza.price}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(
                                context,
                              ).colorScheme.onBackground.withOpacity(0.5),
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                MyMacroWidget(
                  title: 'Calories',
                  value: pizza.macros.calories,
                  icon: FontAwesomeIcons.fire,
                ),
                const SizedBox(width: 10),
                MyMacroWidget(
                  title: 'Protein',
                  value: pizza.macros.proteins,
                  icon: FontAwesomeIcons.drumstickBite,
                ),
                const SizedBox(width: 10),
                MyMacroWidget(
                  title: 'Carbs',
                  value: pizza.macros.carbs,
                  icon: FontAwesomeIcons.breadSlice,
                ),
                const SizedBox(width: 10),
                MyMacroWidget(
                  title: 'Fat',
                  value: pizza.macros.fat,
                  icon: FontAwesomeIcons.cheese,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
