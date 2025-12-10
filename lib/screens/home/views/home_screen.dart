import 'package:cart_repository/cart_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:pizza_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:pizza_app/screens/cart/blocs/add_cart_bloc/add_cart_bloc.dart';
import 'package:pizza_app/screens/cart/blocs/get_cart_bloc/get_cart_bloc.dart';
import 'package:pizza_app/screens/cart/blocs/update_cart_bloc/update_cart_bloc.dart';
import 'package:pizza_app/screens/cart/views/cart_screen.dart';
import 'package:pizza_app/screens/home/blocs/get_pizza_bloc/get_pizza_bloc.dart';
import 'package:pizza_app/screens/home/components/cart_badge.dart';
import 'package:pizza_app/screens/home/components/pizza_grid_item.dart';
import 'package:pizza_app/screens/home/views/details_screen.dart';
import 'package:pizza_repository/pizza_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Helper getter for userId
  String get _userId =>
      context.read<AuthenticationBloc>().state.user?.userId ?? '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_userId.isNotEmpty) {
        context.read<GetCartBloc>().add(GetCart(_userId));
      }
    });
  }

  void _refreshCart() {
    if (_userId.isNotEmpty) {
      context.read<GetCartBloc>().add(GetCart(_userId));
    }
  }

  void _addToCart(Pizza pizza) {
    final cart = Cart(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      pizza: pizza,
      price: pizza.price,
      quantity: 1,
    );

    context.read<AddCartBloc>().add(AddCart(cart, _userId));
  }

  void _navigateToDetails(Pizza pizza) {
    final addCartBloc = context.read<AddCartBloc>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => MultiBlocProvider(
              providers: [BlocProvider.value(value: addCartBloc)],
              child: DetailsScreen(pizza, _userId),
            ),
      ),
    );
  }

  void _navigateToCart() {
    // Read BLoCs before navigation to avoid context issues
    final authBloc = context.read<AuthenticationBloc>();
    final cartBloc = context.read<GetCartBloc>();
    final updateCartBloc = context.read<UpdateCartBloc>();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: authBloc),
                BlocProvider.value(value: cartBloc),
                BlocProvider.value(value: updateCartBloc),
              ],
              child: const CartScreen(),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocListener<AddCartBloc, AddCartState>(
      listener: (context, state) {
        if (state is AddCartSuccess) {
          _refreshCart();

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
        } else if (state is AddCartFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: const [
                  Icon(Icons.error, color: Colors.white),
                  SizedBox(width: 12),
                  Text('Failed to add pizza to cart'),
                ],
              ),
              backgroundColor: Colors.red,
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
          title: Row(
            children: [
              Image.asset('assets/8.png', scale: screenWidth * 0.035),
              SizedBox(width: screenWidth * 0.012),
              Text(
                'PIZZA',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: screenWidth * 0.075,
                ),
              ),
            ],
          ),
          actions: [
            CartBadgeWidget(onTap: _navigateToCart),
            IconButton(
              onPressed: () {
                final bloc = context.read<SignInBloc>();
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: const Text('Sign Out'),
                        content: const Text(
                          'Are you sure you want to sign out?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              bloc.add(SignOutRequired());
                            },
                            child: const Text(
                              'Sign Out',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                );
              },
              icon: const Icon(CupertinoIcons.arrow_right_to_line),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: BlocBuilder<GetPizzaBloc, GetPizzaState>(
            builder: (context, state) {
              if (state is GetPizzaSuccess) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: screenWidth * 0.04,
                    mainAxisSpacing: screenWidth * 0.04,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: state.pizzas.length,
                  itemBuilder: (context, index) {
                    final pizza = state.pizzas[index];
                    return PizzaGridItem(
                      pizza: pizza,
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      onAddToCart: () => _addToCart(pizza),
                      onTap: () => _navigateToDetails(pizza),
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
      ),
    );
  }
}
