import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:favorites_repository/favorites_repository.dart';

part 'add_favorites_event.dart';
part 'add_favorites_state.dart';

class AddFavoritesBloc extends Bloc<AddFavoritesEvent, AddFavoritesState> {
  final FavoritesRepository _favoritesRepository;
  AddFavoritesBloc(this._favoritesRepository) : super(AddFavoritesInitial()) {
    on<AddFavoritesEvent>((event, emit) async {
      if (event is AddFavorite) {
        emit(AddFavoritesProcess(event.favorites.pizza.pizzaId));
        try {
          await _favoritesRepository.addFavorite(event.userId, event.favorites);
          emit(AddFavoritesSuccess(event.favorites.pizza.pizzaId));
        } catch (e) {
          emit(AddFavoritesFailure(
            pizzaId: event.favorites.pizza.pizzaId,
            errorMessage: e.toString(),
          ));
        }
      }
    });
  }
}
