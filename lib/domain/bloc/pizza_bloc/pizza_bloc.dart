import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:pizza_repository/pizza_repository.dart';

part 'pizza_event.dart';

part 'pizza_state.dart';

EventTransformer<E> debounceDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.debounce(duration), mapper);
  };
}

class PizzaBloc extends Bloc<PizzaEvent, PizzaState> {
  PizzaBloc({
    required PizzaFromLocalJsonFileRepository pizzaRepository,
  })  : _pizzaRepository = pizzaRepository,
        super(PizzaState()) {
    on<LoadPizzasInMarketEvent>(
      _getPizzaInMarket,
      transformer: debounceDroppable(
        const Duration(microseconds: 300),
      ),
    );

    on<LoadPizzasInBasketEvent>(
      _getPizzaInBasket,
      transformer: debounceDroppable(
        const Duration(microseconds: 300),
      ),
    );

    on<GetTotalAmountInBasket>(
      _getTotalAmountInBasket,
      transformer: debounceDroppable(
        const Duration(microseconds: 0),
      ),
    );

    on<SetCountPizzaInBasket>(
      _setCountPizzaInBasket,
      transformer: debounceDroppable(
        const Duration(microseconds: 0),
      ),
    );

    on<AddPizzaInBasketEvent>(
      _addPizzaInBasket,
      transformer: debounceDroppable(
        const Duration(microseconds: 300),
      ),
    );
  }

  late final PizzaFromLocalJsonFileRepository _pizzaRepository;

  _getPizzaInMarket(
      LoadPizzasInMarketEvent event, Emitter<PizzaState> emit) async {
    PizzaListModel pizzas = await _pizzaRepository.getPizzasForMarket();
    emit(state.copyWith(pizzasInMarket: pizzas.getPizzas));
  }

  _getPizzaInBasket(
      LoadPizzasInBasketEvent event, Emitter<PizzaState> emit) async {
    ShoppingBasketModel pizzas = await _pizzaRepository.getPizzasForBasket();
    emit(state.copyWith(pizzasInBasket: pizzas.getPizzaInBasket));
  }

  _getTotalAmountInBasket(
      GetTotalAmountInBasket event, Emitter<PizzaState> emit) async {
    ShoppingBasketModel pizzas = await _pizzaRepository.getPizzasForBasket();
    double totalAmount = pizzas.totalAmount;
    emit(state.copyWith(totalAmount: totalAmount));
  }

  _setCountPizzaInBasket(
      SetCountPizzaInBasket event, Emitter<PizzaState> emit) async {
    ShoppingBasketModel pizzas = await _pizzaRepository.getPizzasForBasket();
    pizzas.getPizzaInBasket[event.position].countPizza = event.count;
    await _pizzaRepository.writeInPizzasInBasket(pizzas);
    ShoppingBasketModel newPizzas = await _pizzaRepository.getPizzasForBasket();
    emit(
      state.copyWith(
        pizzasInBasket: newPizzas.getPizzaInBasket,
        totalAmount: newPizzas.totalAmount,
      ),
    );
  }

  _addPizzaInBasket(
      AddPizzaInBasketEvent event, Emitter<PizzaState> emit) async {
    PizzaListModel marketPizzas = await _pizzaRepository.getPizzasForMarket();
    ShoppingBasketModel basketPizzas =
        await _pizzaRepository.getPizzasForBasket();
    int index = event.position;

    basketPizzas.addPizzaInBasket(
        namePizza: marketPizzas.getPizzas[index].namePizza,
        pricePizza: marketPizzas.getPizzas[index].pricePizza);
    marketPizzas.getPizzas.removeAt(index);

    _pizzaRepository.writeInPizzasInMarket(marketPizzas);
    _pizzaRepository.writeInPizzasInBasket(basketPizzas);

    emit(state.copyWith(
        pizzasInMarket: marketPizzas.getPizzas,
        pizzasInBasket: basketPizzas.getPizzaInBasket));
  }
}
