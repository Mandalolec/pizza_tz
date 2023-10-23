class Pizza {
  String namePizza;
  String pricePizza;
  int countPizza;

  Pizza({
    required this.namePizza,
    required this.pricePizza,
    required this.countPizza
  });

  factory Pizza.fromJson(Map<String, dynamic> json) {
    return Pizza(
        namePizza: json['name_pizza'],
        pricePizza: json['price_pizza'],
        countPizza: json['count_pizza']
    );
  }

  Map<String, dynamic> toJson() => {
    'name_pizza': namePizza,
    'price_pizza': pricePizza,
    'count_pizza': countPizza
  };

  @override
  String toString() {
    return "{namePizza = $namePizza, "
        "pricePizza = $pricePizza, "
        "countPizza = $countPizza}";
  }
}