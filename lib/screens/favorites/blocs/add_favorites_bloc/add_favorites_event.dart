part of 'add_favorites_bloc.dart';

sealed class AddFavoritesEvent extends Equatable {
  const AddFavoritesEvent();

  @override
  List<Object> get props => [];
}

class AddFavorite extends AddFavoritesEvent {
  final Favorites favorites;
  final String userId;

  const AddFavorite(this.favorites, this.userId);

  @override
  List<Object> get props => [favorites, userId];
}
