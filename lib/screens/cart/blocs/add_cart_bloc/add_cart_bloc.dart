import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cart_repository/cart_repository.dart';

part 'add_cart_event.dart';
part 'add_cart_state.dart';

class AddCartBloc extends Bloc<AddCartEvent, AddCartState> {
  final CartRepository _cartRepository;

  AddCartBloc(this._cartRepository) : super(AddCartInitial()) {
    on<AddCart>((event, emit) async {
      emit(AddCartProcess(event.cart.pizza.pizzaId));
      try {
        await _cartRepository.addCart(event.userId, event.cart);
        emit(AddCartSuccess(event.cart.pizza.pizzaId));
      } catch (e) {
        emit(AddCartFailure(pizzaId: event.cart.pizza.pizzaId));
      }
    });
  }
}


