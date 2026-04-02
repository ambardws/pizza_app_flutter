import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:favorites_repository/favorites_repository.dart';
import 'package:favorites_repository/src/favorites_repo.dart';

part 'get_favorites_event.dart';
part 'get_favorites_state.dart';

class GetFavoritesBloc extends Bloc<GetFavoritesEvent, GetFavoritesState> {
  final FavoritesRepository _favoritesRepository;
  GetFavoritesBloc(this._favoritesRepository) : super(GetFavoritesInitial()) {
    on<GetFavorites>((event, emit) async {
      emit(GetFavoritesProcess(userId: event.userId));
      try {
        final favorites = await _favoritesRepository.getFavorites(event.userId);
        emit(GetFavoritesSuccess(favorites));
      } catch (e) {
        emit(GetFavoritesFailure(userId: event.userId));
      }
    });
  }
}
