part of 'pizza_bloc.dart';

class PizzaState {
  final List<Pizza> pizzasInMarket;
  final List<Pizza> pizzasInBasket;

  PizzaState({
    this.pizzasInMarket = const [],
    this.pizzasInBasket = const [],
  });

  PizzaState copyWith({
    List<Pizza>? pizzasInMarket,
    List<Pizza>? pizzasInBasket,
  }) {
    return PizzaState(
      pizzasInMarket: pizzasInMarket ?? this.pizzasInMarket,
      pizzasInBasket: pizzasInBasket ?? this.pizzasInBasket,
    );
  }
}
