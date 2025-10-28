import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizza_app/components/macro.dart';
import 'package:pizza_repository/src/models/pizza.dart';

class DetailsScreen extends StatelessWidget {
  final Pizza pizza;
  const DetailsScreen(this.pizza, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.background),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width - (40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: ([
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5,
                    offset: const Offset(3, 3),
                  ),
                ]),
                image: DecorationImage(
                  image: NetworkImage(pizza.picture),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: ([
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5,
                    offset: const Offset(3, 3),
                  ),
                ]),
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
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                if (pizza.discount > 0) ...[
                                  Text(
                                    '\$${pizza.price}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
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
                        SizedBox(width: 10),
                        MyMacroWidget(
                          title: 'Protein',
                          value: pizza.macros.proteins,
                          icon: FontAwesomeIcons.drumstickBite,
                        ),
                        SizedBox(width: 10),
                        MyMacroWidget(
                          title: 'Carbs',
                          value: pizza.macros.carbs,
                          icon: FontAwesomeIcons.breadSlice,
                        ),
                        SizedBox(width: 10),
                        MyMacroWidget(
                          title: 'Fat',
                          value: pizza.macros.fat,
                          icon: FontAwesomeIcons.cheese,
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    SizedBox(
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
                          // Handle add to cart action
                        },
                        child: Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
