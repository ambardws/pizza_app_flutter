part of 'get_favorites_bloc.dart';

sealed class GetFavoritesEvent extends Equatable {
  const GetFavoritesEvent();

  @override
  List<Object> get props => [];
}

class GetFavorites extends GetFavoritesEvent {
  final String userId;
  const GetFavorites({required this.userId});

  @override
  List<Object> get props => [userId];
}
