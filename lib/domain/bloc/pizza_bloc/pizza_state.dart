part of 'pizza_bloc.dart';

class PizzaState {
  final List<Pizza> pizzasInMarket;
  final List<Pizza> pizzasInBasket;
  final double totalAmount;

  PizzaState({
    this.pizzasInMarket = const [],
    this.pizzasInBasket = const [],
    this.totalAmount = 0.0,
  });

  PizzaState copyWith({
    List<Pizza>? pizzasInMarket,
    List<Pizza>? pizzasInBasket,
    double? totalAmount,
  }) {
    return PizzaState(
      pizzasInMarket: pizzasInMarket ?? this.pizzasInMarket,
      pizzasInBasket: pizzasInBasket ?? this.pizzasInBasket,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}
