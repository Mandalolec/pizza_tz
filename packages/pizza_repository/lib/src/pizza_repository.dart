import 'dart:convert';
import 'dart:io';

import 'models/pizza_set.dart';


abstract class IPizzaRepository {
  Future<PizzaList> readPizzaList();

  Future<void> writePizzaList(PizzaList pizzaList);
}

class PizzaRepository extends IPizzaRepository {
  Future<File> get _file async {
    return File('packages/pizza_repository/assets/json/pizza_list.json');
  }

  @override
  Future<PizzaList> readPizzaList() async {
    String content = await getJsonContent();
    var jsonResponse = jsonDecode(content);
    PizzaList list = PizzaList.fromJson(jsonResponse);
    return list;
  }

  Future<String> getJsonContent() async {
    File file = await _file;
    return file.readAsString();
  }

  @override
  Future<void> writePizzaList(PizzaList pizzaList) async {
    setJsonContent('');
    setJsonContent(jsonEncode(pizzaList));
  }

  Future<void> setJsonContent(String content) async {
    File file = await _file;
    file.writeAsStringSync(content);
  }
}