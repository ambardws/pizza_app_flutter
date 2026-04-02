part of 'remove_favorites_bloc.dart';

sealed class RemoveFavoritesEvent extends Equatable {
  const RemoveFavoritesEvent();

  @override
  List<Object> get props => [];
}

class RemoveFavorites extends RemoveFavoritesEvent {
  final String userId;
  final String id;

  const RemoveFavorites(this.userId, this.id);

  @override
  List<Object> get props => [userId, id];
}
