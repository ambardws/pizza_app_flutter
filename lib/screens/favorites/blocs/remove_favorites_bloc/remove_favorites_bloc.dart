import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'remove_favorites_event.dart';
part 'remove_favorites_state.dart';

class RemoveFavoritesBloc extends Bloc<RemoveFavoritesEvent, RemoveFavoritesState> {
  RemoveFavoritesBloc() : super(RemoveFavoritesInitial()) {
    on<RemoveFavoritesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
