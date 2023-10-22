import 'package:flutter/material.dart';
import 'pizza.dart';

class PizzaListModel with ChangeNotifier {
  final List<Pizza> _pizzaList;

  List<Pizza> get getPizzas => _pizzaList;
  set setPizzas(value) => _pizzaList.addAll(value);

  final List<int> _indexesPizzasList = <int>[];

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

  PizzaListModel.fromJson(Map<String, dynamic> json)
      : _pizzaList = List<dynamic>.from(json['list_pizza'])
      .map((i) => Pizza.fromJson(i))
      .toList();

  Map<String, dynamic> toJson() => {
    'list_pizza': _pizzaList.map((item) => item.toJson()).toList()
  };
}
