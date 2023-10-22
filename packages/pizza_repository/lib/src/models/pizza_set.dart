import 'package:flutter/material.dart';
import 'pizza.dart';

class PizzaListModel with ChangeNotifier {
  final List<Pizza> _pizzaList;

  List<Pizza> get getPizzas => _pizzaList;
  set setPizzas(value) {
    _pizzaList.clear();
    _pizzaList.addAll(value);
  }

  set addPizza(Pizza pizza) {
    _pizzaList.add(pizza);
    notifyListeners();
  }

  void removePizza(int position) {
    _pizzaList.removeAt(position);
    notifyListeners();
  }

  PizzaListModel.fromJson(Map<String, dynamic> json)
      : _pizzaList = List<dynamic>.from(json['list_pizza'])
      .map((i) => Pizza.fromJson(i))
      .toList();

  Map<String, dynamic> toJson() => {
    'list_pizza': _pizzaList.map((item) => item.toJson()).toList()
  };
}
