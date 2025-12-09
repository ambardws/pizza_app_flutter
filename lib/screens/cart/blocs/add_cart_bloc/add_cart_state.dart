part of 'add_cart_bloc.dart';

sealed class AddCartState extends Equatable {
  const AddCartState();

  @override
  List<Object> get props => [];
}

final class AddCartInitial extends AddCartState {}

class AddCartFailure extends AddCartState {
  final String? pizzaId;

  const AddCartFailure({this.pizzaId});

  @override
  List<Object> get props => [pizzaId ?? ''];
}

class AddCartProcess extends AddCartState {
  final String pizzaId;

  const AddCartProcess(this.pizzaId);

  @override
  List<Object> get props => [pizzaId];
}

class AddCartSuccess extends AddCartState {
  final String pizzaId;

  const AddCartSuccess(this.pizzaId);

  @override
  List<Object> get props => [pizzaId];
}