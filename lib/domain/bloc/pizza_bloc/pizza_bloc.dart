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
  PizzaBloc({required PizzaFromLocalJsonFileRepository pizzaRepository})
      : _pizzaRepository = pizzaRepository,
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

    on<AddPizzaInBasketEvent>(
      _addPizzaInBasket,
      transformer: debounceDroppable(
        const Duration(microseconds: 300),
      ),
    );
  }

  late final PizzaFromLocalJsonFileRepository _pizzaRepository;

  _getPizzaInMarket(LoadPizzasInMarketEvent event, Emitter<PizzaState> emit) async {
    final pizzas = await _pizzaRepository.getPizzasForMarket();
    emit(state.copyWith(pizzasInMarket: pizzas.getPizzas));
  }

  _getPizzaInBasket(LoadPizzasInBasketEvent event, Emitter<PizzaState> emit) async {
    final pizzas = await _pizzaRepository.getPizzasForBasket();
    emit(state.copyWith(pizzasInBasket: pizzas.getPizzaInBasket));
  }

  _addPizzaInBasket(AddPizzaInBasketEvent event, Emitter<PizzaState> emit) async {
    final marketPizzas = await _pizzaRepository.getPizzasForMarket();
    final basketPizzas = await _pizzaRepository.getPizzasForBasket();
    final index = event.position;


    basketPizzas.addPizzaInBasket(
        namePizza: marketPizzas.getPizzas[index].namePizza,
        pricePizza: marketPizzas.getPizzas[index].pricePizza
    );
    marketPizzas.getPizzas.removeAt(index);

    _pizzaRepository.writeInPizzasInMarket(marketPizzas);
    _pizzaRepository.writeInPizzasInBasket(basketPizzas);

    emit(state.copyWith(pizzasInMarket: marketPizzas.getPizzas, pizzasInBasket: basketPizzas.getPizzaInBasket));
  }
}
