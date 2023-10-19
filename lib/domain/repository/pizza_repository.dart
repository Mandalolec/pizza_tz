import 'dart:convert';
import 'dart:io';

import 'package:pizza_tz/domain/repository/i_pizza_repository.dart';

import '../../data/pizza_set.dart';

class PizzaRepository extends IPizzaRepository {
  final File file = File('C:/Users/Kirill.Tyudeshev/StudioProjects/pizza_tz/assets/json/pizza_list.json');

  @override
  Future<PizzaList> readPizzaList() async {
    String content = await file.readAsString();
    var jsonResponse = jsonDecode(content);
    PizzaList list = PizzaList.fromJson(jsonResponse);
    return list;
  }

  @override
  Future<void> writePizzaList(PizzaList pizzaList) async {
    file.writeAsStringSync('');
    file.writeAsStringSync(jsonEncode(pizzaList));
  }
}