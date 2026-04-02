part of 'add_favorites_bloc.dart';

sealed class AddFavoritesState extends Equatable {
  const AddFavoritesState();

  @override
  List<Object> get props => [];
}

final class AddFavoritesInitial extends AddFavoritesState {}

class AddFavoritesFailure extends AddFavoritesState {
  final String? pizzaId;
  final String? errorMessage;

  const AddFavoritesFailure({this.pizzaId, this.errorMessage});

  @override
  List<Object> get props => [pizzaId ?? '', errorMessage ?? ''];
}

class AddFavoritesProcess extends AddFavoritesState {
  final String pizzaId;

  const AddFavoritesProcess(this.pizzaId);

  @override
  List<Object> get props => [pizzaId];
}

class AddFavoritesSuccess extends AddFavoritesState {
  final String pizzaId;

  const AddFavoritesSuccess(this.pizzaId);

  @override
  List<Object> get props => [pizzaId];
}
