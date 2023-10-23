part of 'pizza_bloc.dart';

abstract class PizzaEvent {}

class LoadPizzasInMarketEvent extends PizzaEvent {}

class LoadPizzasInBasketEvent extends PizzaEvent {}

class GetTotalAmountInBasket extends PizzaEvent {}

class SetCountPizzaInBasket extends PizzaEvent {
  final int count;
  final int position;
  SetCountPizzaInBasket(this.count,this.position);
}

class AddPizzaInBasketEvent extends PizzaEvent {
  final int position;
  AddPizzaInBasketEvent(this.position);
}

class GetPizzaMocksForMarketInAdminEvent extends PizzaEvent {}

class AddPizzaMockForMarketInAdminEvent extends PizzaEvent {}

class SetCountPizzaMockForMarketInAdminEvent extends PizzaEvent {
  final int count;
  final int position;
  SetCountPizzaMockForMarketInAdminEvent(this.count, this.position);
}

class ClearAllPizzaMocksForMarketInAdminEvent extends PizzaEvent {}

class AddPizzaInMarketEvent extends PizzaEvent {}

class SetNameOnPizzaMockInAdminEvent extends PizzaEvent {
  final String name;
  final int position;
  SetNameOnPizzaMockInAdminEvent(this.name, this.position);
}

class SetPriceOnPizzaMockInAdminEvent extends PizzaEvent {
  final String price;
  final int position;
  SetPriceOnPizzaMockInAdminEvent(this.price, this.position);
}

class ClearAllPizzasInBasket extends PizzaEvent {}

class SortByPriceASC extends PizzaEvent {}

class SortByPriceDESC extends PizzaEvent {}

class SearchPizza extends PizzaEvent {
  final String query;
  SearchPizza(this.query);
}


