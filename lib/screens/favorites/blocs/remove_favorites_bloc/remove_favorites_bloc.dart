import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:favorites_repository/favorites_repository.dart';

part 'remove_favorites_event.dart';
part 'remove_favorites_state.dart';

class RemoveFavoritesBloc
    extends Bloc<RemoveFavoritesEvent, RemoveFavoritesState> {
  final FavoritesRepository _favoritesRepository;

  RemoveFavoritesBloc(this._favoritesRepository)
    : super(RemoveFavoritesInitial()) {
    on<RemoveFavorites>((event, emit) async {
      emit(RemoveFavoritesProcess(event.id));
      try {
        await _favoritesRepository.removeFavorite(event.userId, event.id);
        emit(RemoveFavoritesSuccess(event.id));
      } catch (e) {
        emit(RemoveFavoritesFailure(event.id));
      }
    });
  }
}
