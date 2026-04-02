part of 'remove_favorites_bloc.dart';

sealed class RemoveFavoritesState extends Equatable {
  const RemoveFavoritesState();

  @override
  List<Object> get props => [];
}

final class RemoveFavoritesInitial extends RemoveFavoritesState {}

class RemoveFavoritesSuccess extends RemoveFavoritesState {
  final String id;

  const RemoveFavoritesSuccess(this.id);

  @override
  List<Object> get props => [id];
}

class RemoveFavoritesFailure extends RemoveFavoritesState {
  final String id;

  const RemoveFavoritesFailure(this.id);

  @override
  List<Object> get props => [id];
}

class RemoveFavoritesProcess extends RemoveFavoritesState {
  final String id;

  const RemoveFavoritesProcess(this.id);

  @override
  List<Object> get props => [id];
}
