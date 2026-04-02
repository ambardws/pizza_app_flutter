import 'package:favorites_repository/favorites_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/extensions/cart_extensions.dart';
import 'package:pizza_app/screens/favorites/blocs/get_favorites_bloc/get_favorites_bloc.dart';
import 'package:pizza_app/screens/favorites/components/empty_favorites.dart';
import 'package:pizza_app/screens/favorites/components/favorites_list.dart';

import 'package:pizza_app/screens/favorites/blocs/remove_favorites_bloc/remove_favorites_bloc.dart';

/// Favorites screen - menampilkan pizza favorit user
/// TODO: Integrate dengan favorite BLoC
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetFavoritesBloc>().add(GetFavorites(userId: context.userId));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocListener<RemoveFavoritesBloc, RemoveFavoritesState>(
      listener: (context, state) {
        if (state is RemoveFavoritesSuccess) {
           // Meminta ulang / Refresh daftar favorites dari database!
           context.read<GetFavoritesBloc>().add(GetFavorites(userId: context.userId));
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<GetFavoritesBloc, GetFavoritesState>(
             builder: (context, state) {
               if (state is GetFavoritesSuccess) {
                 return state.favorites.isEmpty
                     ? EmptyFavorites(
                       context: context,
                       screenWidth: screenWidth,
                       screenHeight: screenHeight,
                     )
                     : FavoritesList(
                       context: context,
                       screenWidth: screenWidth,
                       screenHeight: screenHeight,
                       favoritePizzas: state.favorites,
                     );
               }
   
               if (state is GetFavoritesFailure) {
                 return Center(child: Text('Failed to load favorites'));
               }
   
               if (state is GetFavoritesProcess) {
                 return const Center(child: CircularProgressIndicator());
               }
   
               return const SizedBox.shrink();
             },
          ),
        ),
      ),
    );
  }
}
