part of 'pizza_bloc.dart';

class PizzaState {
  final List<Pizza> pizzasInMarket;
  final List<Pizza> pizzasInBasket;
  final List<Pizza> pizzaInAdmin;
  final double totalAmount;

  PizzaState({
    this.pizzasInMarket = const [],
    this.pizzasInBasket = const [],
    this.pizzaInAdmin = const [],
    this.totalAmount = 0.0,
  });

  PizzaState copyWith({
    List<Pizza>? pizzasInMarket,
    List<Pizza>? pizzasInBasket,
    List<Pizza>? pizzaInAdmin,
    double? totalAmount,
  }) {
    return PizzaState(
      pizzasInMarket: pizzasInMarket ?? this.pizzasInMarket,
      pizzasInBasket: pizzasInBasket ?? this.pizzasInBasket,
      pizzaInAdmin: pizzaInAdmin ?? this.pizzaInAdmin,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}
