
class Pizza {
  final int idPizza;
  final String namePizza;
  final String pricePizza;
  int countPizza = 1;

  Pizza({
    required this.idPizza,
    required this.namePizza,
    required this.pricePizza,
    required this.countPizza
  });

  void increasePizzasCount() {
    countPizza + 1;
  }
}