import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:pizza_app/screens/home/blocs/get_pizza_bloc/get_pizza_bloc.dart';
import 'package:pizza_app/screens/home/views/details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Row(
          children: [
            Image.asset(
              'assets/8.png',
              scale: screenWidth * 0.035,
            ), // Dynamic scale based on screen width
            SizedBox(width: screenWidth * 0.012), // Dynamic width
            Text(
              'PIZZA',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: screenWidth * 0.075, // Dynamic font size
              ),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.cart)),
          IconButton(
            onPressed: () {
              context.read<SignInBloc>().add(SignOutRequired());
            },
            icon: const Icon(CupertinoIcons.arrow_right_to_line),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04), // Dynamic padding
        child: BlocBuilder<GetPizzaBloc, GetPizzaState>(
          builder: (context, state) {
            if (state is GetPizzaSuccess) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: screenWidth * 0.04, // Dynamic spacing
                  mainAxisSpacing: screenWidth * 0.04, // Dynamic spacing
                  childAspectRatio: 0.85, // Increased ratio to give more height
                ),
                itemCount: state.pizzas.length,
                itemBuilder: (context, index) {
                  return Material(
                    elevation: 3,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        screenWidth * 0.05,
                      ), // Dynamic border radius
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(state.pizzas[index]),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex:
                                2, // Reduced from 3 to give more space for text
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  state.pizzas[index].picture,
                                  width: screenWidth * 0.35,
                                  height: screenHeight * 0.15,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex:
                                3, // Increased from 2 to give more space for content
                            child: Padding(
                              padding: EdgeInsets.all(
                                screenWidth * 0.025,
                              ), // Reduced padding
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize:
                                    MainAxisSize
                                        .min, // Important for overflow prevention
                                children: [
                                  // Tags row with better sizing
                                  SizedBox(
                                    height:
                                        screenHeight *
                                        0.025, // Fixed height for tags
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: state.pizzas[index].isVeg
                                                  ? Colors.green.withOpacity(0.2)
                                                  : Colors.red.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    screenWidth * 0.03,
                                                  ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: screenWidth * 0.015,
                                                vertical: screenHeight * 0.002,
                                              ),
                                              child: Text(
                                                state.pizzas[index].isVeg
                                                    ? 'VEG'
                                                    : 'NON-VEG',
                                                style: TextStyle(
                                                  color: state.pizzas[index].isVeg
                                                      ? Colors.green
                                                      : Colors.red,
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
                                              color: Colors.green.withOpacity(
                                                0.2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    screenWidth * 0.03,
                                                  ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: screenWidth * 0.015,
                                                vertical: screenHeight * 0.002,
                                              ),
                                              child: Text(
                                                state.pizzas[index].spicy > 5
                                                    ? '🌶️ SPICY'
                                                    : '🌶️ BALANCE',
                                                style: TextStyle(
                                                  color: state.pizzas[index].spicy > 5
                                                      ? Colors.red
                                                      : Colors.green,
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: screenWidth * 0.02,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.005),
                                  // Title
                                  Text(
                                    state.pizzas[index].name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: screenWidth * 0.032,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  // Description
                                  Text(
                                    state.pizzas[index].description,
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: screenWidth * 0.025,
                                      fontWeight: FontWeight.w300,
                                      height:
                                          1.2, // Line height for better readability
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const Spacer(),
                                  // Price and button row
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              state.pizzas[index].discount > 0
                                                  ? '\$${(state.pizzas[index].price * (1 - state.pizzas[index].discount / 100)).toStringAsFixed(2)}'
                                                  : '\$${state.pizzas[index].price}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: screenWidth * 0.050,
                                                color:
                                                    Theme.of(
                                                      context,
                                                    ).primaryColor,
                                              ),
                                            ),
                                            if (state.pizzas[index].discount >
                                                0) ...{
                                              SizedBox(width: screenWidth * 0.015),
                                              Text(
                                                '\$${state.pizzas[index].price}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: screenWidth * 0.025,
                                                  color: Colors.grey.shade700,
                                                  decoration:
                                                      TextDecoration
                                                          .lineThrough,
                                                ),
                                              ),
                                            },
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: screenWidth * 0.07,
                                        height: screenWidth * 0.07,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {},
                                          icon: Icon(
                                            CupertinoIcons.plus,
                                            color: Colors.white,
                                            size: screenWidth * 0.04,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is GetPizzaLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(child: Text('Failed to load pizzas'));
            }
          },
        ),
      ),
    );
  }
}
