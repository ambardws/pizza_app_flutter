import 'package:pizza_repository/pizza_repository.dart';

abstract class PizzaRepository {
  Future<List<Pizza>> getPizzas();
}
