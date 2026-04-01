part of 'add_cart_bloc.dart';

sealed class AddCartEvent extends Equatable {
  const AddCartEvent();

  @override
  List<Object> get props => [];
}

class AddCart extends AddCartEvent {
  final Cart cart;
  final String userId;

  const AddCart(this.cart, this.userId);

  @override
  List<Object> get props => [cart, userId];
}
