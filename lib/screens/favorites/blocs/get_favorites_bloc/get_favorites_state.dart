part of 'get_favorites_bloc.dart';

sealed class GetFavoritesState extends Equatable {
  const GetFavoritesState();

  @override
  List<Object> get props => [];
}

final class GetFavoritesInitial extends GetFavoritesState {}

final class GetFavoritesProcess extends GetFavoritesState {
  final String userId;
  const GetFavoritesProcess({required this.userId});

  @override
  List<Object> get props => [userId];
}

final class GetFavoritesSuccess extends GetFavoritesState {
  final List<Favorites> favorites;
  const GetFavoritesSuccess(this.favorites);

  @override
  List<Object> get props => [favorites];
}

final class GetFavoritesFailure extends GetFavoritesState {
  final String userId;
  const GetFavoritesFailure({required this.userId});

  @override
  List<Object> get props => [userId];
}
