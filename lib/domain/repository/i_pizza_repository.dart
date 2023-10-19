
import '../../data/pizza_set.dart';


abstract class IPizzaRepository {
  Future<PizzaList> readPizzaList();

  Future<void> writePizzaList(PizzaList pizzaList);
}