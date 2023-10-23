import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pizza_repository/pizza_repository.dart';

abstract class IPizzaRepository {
}

class PizzaFromLocalJsonFileRepository extends IPizzaRepository {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFileForMarket async {
    final path = await _localPath;
    return File('$path/pizza_list.json');
  }

  Future<File> get _localFileForBasket async {
    final path = await _localPath;
    return File('$path/basket_list.json');
  }

  Future<void> createLocalJsonOnDevice(String name) async {
    final file = File("${await _localPath}/$name").create(recursive: true);
    var content = await rootBundle.loadString('assets/json/pizza_list.json');
    debugPrint("Content in root bundle: $content");
    final writer = await file;
    writer.writeAsString(content.toString());
  }

  Future<PizzaListModel> getPizzasForMarket() async {
    var file = await _localFileForMarket;
    final bool existFile = await file.exists();
    if (!existFile) {
      await createLocalJsonOnDevice('pizza_list.json');
      file = await _localFileForMarket;
      return readFileFromPizzasInMarket(file);
    } else {
      return readFileFromPizzasInMarket(file);
    }
  }

  Future<PizzaListModel> readFileFromPizzasInMarket(File file) async {
    final content = file.readAsStringSync();
    var jsonResponse = jsonDecode(content);
    PizzaListModel pizzaListModel = PizzaListModel.fromJson(jsonResponse);
    return pizzaListModel;
  }

  Future<ShoppingBasketModel> getPizzasForBasket() async {
    var file = await _localFileForBasket;
    final bool existFile = await file.exists();
    if (!existFile) {
      await createLocalJsonOnDevice('basket_list.json');
      file = await _localFileForBasket;
      return await readFileFromPizzasInBasket(file);
    } else {
      return await readFileFromPizzasInBasket(file);
    }
  }

  Future<ShoppingBasketModel> readFileFromPizzasInBasket(File file) async {
    final content = await file.readAsString();
    var jsonResponse = jsonDecode(content);
    ShoppingBasketModel shoppingBasketModel = ShoppingBasketModel.fromJson(jsonResponse);
    return shoppingBasketModel;
  }

  Future<void> writeInPizzasInMarket(PizzaListModel pizzaList) async {
    await _setJsonContent('', await _localFileForMarket);
    final pizzas = pizzaList.toJson();
    await _setJsonContent(jsonEncode(pizzas), await _localFileForMarket);
  }

  Future<void> writeInPizzasInBasket(ShoppingBasketModel pizzaList) async {
    await _setJsonContent('', await _localFileForBasket);
    final pizzas = pizzaList.toJson();
    await _setJsonContent(jsonEncode(pizzas), await _localFileForBasket);
  }

  Future<void> _setJsonContent(String content, File file) async {
    file.writeAsStringSync(content);
  }

  Future<List<Pizza>> searchPizza(String query) async {
    final PizzaListModel pizzas = await getPizzasForMarket();
    final List<Pizza> newPizzaList = [];

    for (int i = 0; i < pizzas.getPizzas.length; i++) {
      if (pizzas.getPizzas[i].namePizza.contains(query)) {
        newPizzaList.add(pizzas.getPizzas[i]);
      }
    }

    return newPizzaList;
  }
}