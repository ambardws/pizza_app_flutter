import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_favorites_event.dart';
part 'get_favorites_state.dart';

class GetFavoritesBloc extends Bloc<GetFavoritesEvent, GetFavoritesState> {
  GetFavoritesBloc() : super(GetFavoritesInitial()) {
    on<GetFavoritesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
