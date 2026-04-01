part of 'update_cart_bloc.dart';

sealed class UpdateCartState extends Equatable {
  const UpdateCartState();

  @override
  List<Object> get props => [];
}

final class UpdateCartInitial extends UpdateCartState {}

class UpdateCartProcess extends UpdateCartState {
  final String cartId;

  const UpdateCartProcess(this.cartId);

  @override
  List<Object> get props => [cartId];
}

class UpdateCartSuccess extends UpdateCartState {
  final String cartId;
  final int newQuantity;

  const UpdateCartSuccess(this.cartId, this.newQuantity);

  @override
  List<Object> get props => [cartId, newQuantity];
}

class UpdateCartFailure extends UpdateCartState {
  final String cartId;

  const UpdateCartFailure(this.cartId);

  @override
  List<Object> get props => [cartId];
}
