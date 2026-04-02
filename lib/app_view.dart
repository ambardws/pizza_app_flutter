import 'package:favorites_repository/favorites_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:pizza_app/blocs/theme_bloc/theme_cubit.dart';
import 'package:pizza_app/main_navigation/main_navigation.dart';
import 'package:pizza_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:pizza_app/screens/auth/views/welcome_screen.dart';
import 'package:pizza_app/screens/cart/blocs/add_cart_bloc/add_cart_bloc.dart';
import 'package:pizza_app/screens/cart/blocs/get_cart_bloc/get_cart_bloc.dart';
import 'package:pizza_app/screens/cart/blocs/update_cart_bloc/update_cart_bloc.dart';
import 'package:pizza_app/screens/favorites/blocs/add_favorites_bloc/add_favorites_bloc.dart';
import 'package:pizza_app/screens/favorites/blocs/get_favorites_bloc/get_favorites_bloc.dart';
import 'package:pizza_app/screens/favorites/blocs/remove_favorites_bloc/remove_favorites_bloc.dart';
import 'package:pizza_app/screens/home/blocs/get_pizza_bloc/get_pizza_bloc.dart';
import 'package:pizza_repository/pizza_repository.dart';
import 'package:cart_repository/cart_repository.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Pizza App',
          debugShowCheckedModeBanner: false,
          themeMode: state,
          theme: ThemeData(
            colorScheme: ColorScheme.light(
              background: Colors.grey.shade200,
              onBackground: Colors.black,
              primary: Colors.blue,
              onPrimary: Colors.white,
            ),
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.dark(
              background: Colors.grey.shade900,
              onBackground: Colors.white,
              primary: Colors.blue,
              onPrimary: Colors.white,
            ),
          ),
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: ((context, state) {
              if (state.status == AuthenticationStatus.authenticated) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create:
                          (context) => SignInBloc(
                            context.read<AuthenticationBloc>().userRepository,
                          ),
                    ),
                    BlocProvider(
                      create:
                          (context) =>
                              GetPizzaBloc(context.read<PizzaRepository>())
                                ..add(GetPizza()),
                    ),
                    BlocProvider(
                      create:
                          (context) =>
                              AddCartBloc(context.read<CartRepository>()),
                    ),
                    BlocProvider(
                      create:
                          (context) =>
                              GetCartBloc(context.read<CartRepository>()),
                    ),
                    BlocProvider(
                      create:
                          (context) =>
                              UpdateCartBloc(context.read<CartRepository>()),
                    ),
                    BlocProvider(
                      create:
                          (context) => AddFavoritesBloc(
                            context.read<FavoritesRepository>(),
                          ),
                    ),
                    BlocProvider(
                      create:
                          (context) => GetFavoritesBloc(
                            context.read<FavoritesRepository>(),
                          ),
                    ),
                    BlocProvider(
                      create:
                          (context) => RemoveFavoritesBloc(
                            context.read<FavoritesRepository>(),
                          ),
                    ),
                  ],
                  child: const MainNavigation(),
                );
              } else {
                return const WelcomeScreen();
              }
            }),
          ),
        );
      },
    );
  }
}
