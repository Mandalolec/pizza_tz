import 'package:pizza_repository/pizza_repository.dart';
import 'package:pizza_tz/domain/bloc/pizza_bloc/pizza_bloc.dart';
import 'package:test/test.dart';
import 'package:flutter/foundation.dart';
import 'package:bloc_test/bloc_test.dart';


void main() {
  group("Тесты с данными", () {
    final repos = PizzaRepository();

    test("Получение данных через репозиторий", () async {
      PizzaList list = await repos.readPizzaList();
      expect(2, list.getPizzas.length);
      debugPrint(list.getPizzas.toString());
    });

    test("Добавление данных в json", () async {
      PizzaList list = await repos.readPizzaList();
      repos.writePizzaList(list);
      debugPrint(list.getPizzas.toString());
      list = await repos.readPizzaList();
      expect(2, list.getPizzas.length);
    });

    test("Получение данных через репозиторий по отдельности", () async {
      PizzaList list = await repos.readPizzaList();
      for (Pizza item in list.getPizzas) {
        expect("{idPizza = 1, namePizza = PapaRonya, pricePizza = \$10000, countPizza = 1}",  list.getPizzas.first.toString());
        debugPrint(item.toString());
      }
    });
  });

  group("Bloc тесты", () {
    final repos = PizzaRepository();
    blocTest(
      'Emit [state] when event is added',
      build: () => PizzaBloc(pizzaRepository: repos),
      act: (bloc) => bloc.add(PizzaLoadEvent()),
      expect: () => []
    );
  });
}
