class Pizza {
  final int idPizza;
  final String namePizza;
  final String pricePizza;
  int countPizza;

  Pizza({
    required this.idPizza,
    required this.namePizza,
    required this.pricePizza,
    required this.countPizza
  });

  factory Pizza.fromJson(Map<String, dynamic> json) {
    return Pizza(idPizza: json['id_pizza'],
        namePizza: json['name_pizza'],
        pricePizza: json['price_pizza'],
        countPizza: json['count_pizza']
    );
  }

  Map<String, dynamic> toJson() => {
    'id_pizza': idPizza,
    'name_pizza': namePizza,
    'price_pizza': pricePizza,
    'count_pizza': countPizza
  };

  @override
  String toString() {
    return "{idPizza = $idPizza, "
        "namePizza = $namePizza, "
        "pricePizza = $pricePizza, "
        "countPizza = $countPizza}";
  }
}