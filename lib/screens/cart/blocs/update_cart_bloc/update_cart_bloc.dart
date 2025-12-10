import 'package:bloc/bloc.dart';
import 'package:cart_repository/cart_repository.dart';
import 'package:equatable/equatable.dart';

part 'update_cart_event.dart';
part 'update_cart_state.dart';

class UpdateCartBloc extends Bloc<UpdateCartEvent, UpdateCartState> {
  final CartRepository _cartRepository;
  UpdateCartBloc(this._cartRepository) : super(UpdateCartInitial()) {
    on<IncrementCartQuantity>(_onIncrementCartQuantity);
    on<DecrementCartQuantity>(_onDecrementCartQuantity);
    on<RemoveCartItem>(_onRemoveCartItem);
  }

  Future<void> _onIncrementCartQuantity(
    IncrementCartQuantity event,
    Emitter<UpdateCartState> emit,
  ) async {
    emit(UpdateCartProcess(event.cartId));
    try {
      await _cartRepository.updateCartQuantity(
        event.userId,
        event.cartId,
        event.currentQuantity + 1,
      );
      emit(UpdateCartSuccess(event.cartId, event.currentQuantity + 1));
    } catch (e) {
      emit(UpdateCartFailure(event.cartId));
    }
  }

  Future<void> _onDecrementCartQuantity(
    DecrementCartQuantity event,
    Emitter<UpdateCartState> emit,
  ) async {
    // Prevent quantity from going below 1
    if (event.currentQuantity <= 1) {
      emit(UpdateCartFailure(event.cartId));
      return;
    }

    emit(UpdateCartProcess(event.cartId));
    try {
      await _cartRepository.updateCartQuantity(
        event.userId,
        event.cartId,
        event.currentQuantity - 1,
      );
      emit(UpdateCartSuccess(event.cartId, event.currentQuantity - 1));
    } catch (e) {
      emit(UpdateCartFailure(event.cartId));
    }
  }

  Future<void> _onRemoveCartItem(
    RemoveCartItem event,
    Emitter<UpdateCartState> emit,
  ) async {
    emit(UpdateCartProcess(event.cartId));
    try {
      await _cartRepository.removeCart(event.cartId, event.userId);
      emit(UpdateCartSuccess(event.cartId, 0));
    } catch (e) {
      emit(UpdateCartFailure(event.cartId));
    }
  }
}
