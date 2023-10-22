import 'package:flutter/foundation.dart';

import 'pizza.dart';

class ShoppingBasketModel with ChangeNotifier {
  final List<Pizza> _pizzaInBasket;

  List<Pizza> get getPizzaInBasket => _pizzaInBasket;

  void addPizzaInBasket({
    required String namePizza,
    required String pricePizza,
  }) {
    int countPizza = 1;
    Pizza pizza = Pizza(
        namePizza: namePizza,
        pricePizza: pricePizza,
        countPizza: countPizza);

    List<String> pizzasNameList = [];
    for (var item in _pizzaInBasket) {
      pizzasNameList.add(item.namePizza);
    }

    if (pizzasNameList.contains(pizza.namePizza)) {
      for (var item in _pizzaInBasket) {
        if (item.namePizza == pizza.namePizza) {
          item.countPizza++;
        }
      }
    } else {
      _pizzaInBasket.add(pizza);
      notifyListeners();
    }
  }

  void removePizzasInBasket() {
    _pizzaInBasket.clear();
    notifyListeners();
  }

  int get pizzaInBasketCount => _pizzaInBasket.length;

  double get totalAmount {
    double total = 0.0;
    for (var pizza in _pizzaInBasket) {
      total += (double.parse(pizza.pricePizza) * pizza.countPizza);
    }
    return total;
  }

  ShoppingBasketModel.fromJson(Map<String, dynamic> json)
      : _pizzaInBasket = List<dynamic>.from(json['list_pizza'])
      .map((i) => Pizza.fromJson(i))
      .toList();

  Map<String, dynamic> toJson() => {
    'list_pizza': _pizzaInBasket.map((item) => item.toJson()).toList()
  };
}
