part of 'get_cart_bloc.dart';

sealed class GetCartEvent extends Equatable {
  const GetCartEvent();

  @override
  List<Object> get props => [];
}

class GetCart extends GetCartEvent {
  final String userId;

  const GetCart(this.userId);

  @override
  List<Object> get props => [userId];
}
