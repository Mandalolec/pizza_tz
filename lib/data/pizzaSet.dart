import 'package:flutter/material.dart';
import 'package:pizza_tz/models/pizza.dart';

class PizzaList with ChangeNotifier {
  final List<Pizza> _pizzaList = <Pizza> [
    Pizza(1, "Original", "8", "assets/image/pizza0.png"),
    Pizza(2, "Buffalo", "10", "assets/image/pizza1.png"),
    Pizza(3, "Sun Marzano", "6", "assets/image/pizza2.png"),
    Pizza(4, "Pepperoni", "11", "assets/image/pizza3.png"),
    Pizza(5, "Mexican", "13", "assets/image/pizza4.png"),
    Pizza(6, "Diablo", "14", "assets/image/pizza5.png"),
  ];

  List<Pizza> get getPizzas => _pizzaList;

  final List<int> _indexesPizzasList = <int> [];

  set addPizza(Pizza pizza) {
    createIndexesPizzasList();

    if (_indexesPizzasList.contains(pizza.idPizza)) {
      pizza.idPizza = _indexesPizzasList.last + 1;
    }

    _pizzaList.add(pizza);
    notifyListeners();
  }

  void createIndexesPizzasList() {
    _indexesPizzasList.clear();
    for (Pizza item in _pizzaList) {
      _indexesPizzasList.add(item.idPizza);
    }
  }
}