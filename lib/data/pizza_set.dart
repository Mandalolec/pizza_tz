import 'package:flutter/material.dart';
import 'package:pizza_tz/domain/models/pizza.dart';

class PizzaList with ChangeNotifier {
  final List<Pizza> _pizzaList = <Pizza> [];

  List<Pizza> get getPizzas => _pizzaList;

  final List<int> _indexesPizzasList = <int> [];

  set addPizza(Pizza pizza) {
    createIndexesPizzasList();
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