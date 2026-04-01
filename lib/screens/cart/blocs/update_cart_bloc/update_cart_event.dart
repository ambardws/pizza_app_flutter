part of 'update_cart_bloc.dart';

sealed class UpdateCartEvent extends Equatable {
  const UpdateCartEvent();

  @override
  List<Object> get props => [];
}

class IncrementCartQuantity extends UpdateCartEvent {
  final String userId;
  final String cartId;
  final int currentQuantity;

  const IncrementCartQuantity(this.userId, this.cartId, this.currentQuantity);

  @override
  List<Object> get props => [userId, cartId, currentQuantity];
}

class DecrementCartQuantity extends UpdateCartEvent {
  final String userId;
  final String cartId;
  final int currentQuantity;

  const DecrementCartQuantity(this.userId, this.cartId, this.currentQuantity);

  @override
  List<Object> get props => [userId, cartId, currentQuantity];
}

class RemoveCartItem extends UpdateCartEvent {
  final String userId;
  final String cartId;

  const RemoveCartItem(this.userId, this.cartId);

  @override
  List<Object> get props => [userId, cartId];
}
