import 'package:flutter/foundation.dart';

import 'package:pizza_tz/data/model/pizza.dart';

class ShoppingBasket with ChangeNotifier {
  final List<Pizza> _pizzaInBasket = [];

  List<Pizza> get pizzaInBasket => _pizzaInBasket;

  void addPizzaInBasket({required int idPizza, required String namePizza, required String pricePizza}) {
    int countPizza = 1;
    Pizza pizza = Pizza(
        idPizza: idPizza,
        namePizza: namePizza,
        pricePizza: pricePizza,
        countPizza: countPizza
    );

    _pizzaInBasket.add(pizza);
    notifyListeners();
  }

  void removePizzaInBasket(int position) {
    _pizzaInBasket.removeAt(position);
    notifyListeners();
  }

  int get pizzaInBasketCount => _pizzaInBasket.length;

  double get totalAmount {
    var total = 0.0;
    for (var pizza in _pizzaInBasket) {
      total += (pizza.pricePizza * pizza.countPizza) as double;
    }
    return total;
  }
}