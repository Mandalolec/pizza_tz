part of 'pizza_bloc.dart';

abstract class PizzaState {}

class PizzaInitialState extends PizzaState {}

class PizzaLoadingState extends PizzaState {}

class PizzaLoadedState extends PizzaState {
  final List<Pizza> pizzaList;
  PizzaLoadedState({
    required this.pizzaList
  });
}

class PizzaErrorState extends PizzaState {}
