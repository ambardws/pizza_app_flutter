import 'package:cart_repository/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/app_view.dart';
import 'package:pizza_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:pizza_app/blocs/theme_bloc/theme_cubit.dart';
import 'package:pizza_repository/pizza_repository.dart';
import 'package:user_repository/user_repository.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(create: (context) => userRepository),
        RepositoryProvider<PizzaRepository>(
          create: (context) => FirebasePizzaRepo(),
        ),
        RepositoryProvider<CartRepository>(
          create: (context) => FirebaseCartRepo(),
        ),
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
      ],
      child: BlocProvider<AuthenticationBloc>(
        create:
            (context) => AuthenticationBloc(
              userRepository: context.read<UserRepository>(),
            ),
        child: const MyAppView(),
      ),
    );
  }
}
