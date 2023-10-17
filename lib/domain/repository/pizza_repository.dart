import 'package:pizza_tz/domain/models/pizza.dart';

abstract class PizzaRepository {
  Future<Pizza> getPizza ({
    required int idPizza,
    required String namePizza,
    required int pricePizza,
    required int countPizza
  });
}