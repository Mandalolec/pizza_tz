import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pizza_repository/pizza_repository.dart';
import 'package:pizza_tz/domain/bloc/pizza_bloc/pizza_bloc.dart';
import 'package:bloc_test/bloc_test.dart';


void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("Тесты с данными", () {
    final repos = PizzaFromLocalJsonFileRepository();

    test("Получение данных через репозиторий", () async {
      PizzaListModel list = await repos.getPizzasForMarket();
      expect(2, list.getPizzas.length);
      debugPrint(list.getPizzas.toString());
    });

    test("Добавление данных в json", () async {
      PizzaListModel list = await repos.getPizzasForMarket();
      repos.writeInPizzasInMarket(list);
      debugPrint(list.getPizzas.toString());
      list = await repos.getPizzasForMarket();
      expect(2, list.getPizzas.length);
    });

    test("Получение данных через репозиторий по отдельности", () async {
      PizzaListModel list = await repos.getPizzasForMarket();
      for (Pizza item in list.getPizzas) {
        expect("{idPizza = 1, namePizza = PapaRonya, pricePizza = \$10000, countPizza = 1}",  list.getPizzas.first.toString());
        debugPrint(item.toString());
      }
    });
  });

  group("Bloc тесты", () {
    final repos = PizzaFromLocalJsonFileRepository();
    blocTest(
      'Emit [state] when event is added',
      build: () => PizzaBloc(pizzaRepository: repos),
      act: (bloc) => bloc.add(LoadPizzasInMarketEvent()),
      expect: () => []
    );
  });
}
