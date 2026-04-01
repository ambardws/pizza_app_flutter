import 'package:bloc/bloc.dart';
import 'package:cart_repository/cart_repository.dart';
import 'package:equatable/equatable.dart';

part 'get_cart_event.dart';
part 'get_cart_state.dart';

class GetCartBloc extends Bloc<GetCartEvent, GetCartState> {
  final CartRepository _cartRepository;

  GetCartBloc(this._cartRepository) : super(GetCartInitial()) {
    on<GetCart>((event, emit) async {
      if (state is! GetCartSuccess) {
        emit(GetCartProcess());
      }
      try {
        final carts = await _cartRepository.getCarts(event.userId);
        emit(GetCartSuccess(carts));
      } catch (e) {
        emit(GetCartFailure(userId: event.userId));
      }
    });
  }
}
