import 'package:pizza_tz/domain/repository/pizza_repository.dart';
import 'package:test/test.dart';
import 'package:flutter/foundation.dart';


void main() {
  test("Получение данных через репозиторий", () async {
    final repos = PizzaRepository();
    var list = await repos.readPizzaList();
    expect(2, list.getPizzas.length);
    debugPrint(list.getPizzas.toString());
  });

  test("Добавление данных в json", () async {
    final repos = PizzaRepository();
    var list = await repos.readPizzaList();
    repos.writePizzaList(list);
    debugPrint(list.getPizzas.toString());
    list = await repos.readPizzaList();
    expect(2, list.getPizzas.length);
  });
}