part of 'get_cart_bloc.dart';

sealed class GetCartState extends Equatable {
  const GetCartState();
  
  @override
  List<Object> get props => [];
}

final class GetCartInitial extends GetCartState {}

class GetCartProcess extends GetCartState {}
class GetCartSuccess extends GetCartState {
  final List<Cart> carts;

  const GetCartSuccess(this.carts);

  @override
  List<Object> get props => [carts];
}
class GetCartFailure extends GetCartState {
  final String? userId;

  const GetCartFailure({this.userId});

  @override
  List<Object> get props => [userId ?? ''];
}