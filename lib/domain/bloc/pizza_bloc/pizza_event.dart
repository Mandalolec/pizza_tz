part of 'pizza_bloc.dart';

abstract class PizzaEvent {}

class LoadPizzasInMarketEvent extends PizzaEvent {}

class LoadPizzasInBasketEvent extends PizzaEvent {}

class AddPizzaInMarketEvent extends PizzaEvent {
  final int position;
  AddPizzaInMarketEvent(this.position);
}

class AddPizzaInBasketEvent extends PizzaEvent {
  final int position;
  AddPizzaInBasketEvent(this.position);
}

class AddPizzaMockForMarketInAdminEvent extends PizzaEvent {}
