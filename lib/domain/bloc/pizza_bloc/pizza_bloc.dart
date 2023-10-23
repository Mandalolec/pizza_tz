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

    on<GetPizzaMocksForMarketInAdminEvent>(
      _getPizzaMockForMarketInAdmin,
      transformer: debounceDroppable(
        const Duration(microseconds: 0),
      ),
    );

    on<AddPizzaMockForMarketInAdminEvent>(
      _addPizzaMockForMarketInAdmin,
      transformer: debounceDroppable(
        const Duration(microseconds: 0),
      ),
    );

    on<SetCountPizzaMockForMarketInAdminEvent>(
      _setCountPizzaMockForMarketInAdmin,
      transformer: debounceDroppable(
        const Duration(microseconds: 0),
      ),
    );

    on<ClearAllPizzaMocksForMarketInAdminEvent>(
      _clearAllPizzaMocksForMarketInAdminEvent,
      transformer: debounceDroppable(
        const Duration(microseconds: 0),
      ),
    );

    on<AddPizzaInMarketEvent>(
      _addPizzaInMarketEvent,
      transformer: debounceDroppable(
        const Duration(microseconds: 0),
      ),
    );

    on<SetNameOnPizzaMockInAdminEvent>(
      _setNameOnPizzasMockInAdmin,
      transformer: debounceDroppable(
        const Duration(microseconds: 0),
      ),
    );

    on<SetPriceOnPizzaMockInAdminEvent>(
      _setPriceOnPizzaMockInAdmin,
      transformer: debounceDroppable(
        const Duration(microseconds: 0),
      ),
    );

    on<ClearAllPizzasInBasket>(
      _clearAllPizzasInBasket,
      transformer: debounceDroppable(
        const Duration(microseconds: 0),
      ),
    );

    on<SortByPriceASC>(
      _sortByPriceASC,
      transformer: debounceDroppable(
        const Duration(microseconds: 0),
      ),
    );

    on<SortByPriceDESC>(
      _sortByPriceDESC,
      transformer: debounceDroppable(
        const Duration(microseconds: 0),
      ),
    );

    on<SearchPizza>(
      _searchPizza,
      transformer: debounceDroppable(
        const Duration(microseconds: 0),
      ),
    );
  }

  late final PizzaFromLocalJsonFileRepository _pizzaRepository;

  _getPizzaInMarket(
    LoadPizzasInMarketEvent event,
    Emitter<PizzaState> emit,
  ) async {
    PizzaListModel pizzas = await _pizzaRepository.getPizzasForMarket();
    emit(
      state.copyWith(pizzasInMarket: pizzas.getPizzas),
    );
  }

  _getPizzaInBasket(
    LoadPizzasInBasketEvent event,
    Emitter<PizzaState> emit,
  ) async {
    ShoppingBasketModel pizzas = await _pizzaRepository.getPizzasForBasket();
    emit(
      state.copyWith(pizzasInBasket: pizzas.getPizzaInBasket),
    );
  }

  _getTotalAmountInBasket(
    GetTotalAmountInBasket event,
    Emitter<PizzaState> emit,
  ) async {
    ShoppingBasketModel pizzas = await _pizzaRepository.getPizzasForBasket();
    double totalAmount = pizzas.totalAmount;
    emit(
      state.copyWith(totalAmount: totalAmount),
    );
  }

  _setCountPizzaInBasket(
    SetCountPizzaInBasket event,
    Emitter<PizzaState> emit,
  ) async {
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
    AddPizzaInBasketEvent event,
    Emitter<PizzaState> emit,
  ) async {
    PizzaListModel marketPizzas = await _pizzaRepository.getPizzasForMarket();
    ShoppingBasketModel basketPizzas =
        await _pizzaRepository.getPizzasForBasket();
    int index = event.position;

    basketPizzas.addPizzaInBasket(
      namePizza: marketPizzas.getPizzas[index].namePizza,
      pricePizza: marketPizzas.getPizzas[index].pricePizza,
      countPizza: marketPizzas.getPizzas[index].countPizza,
    );

    marketPizzas.getPizzas.removeAt(index);

    _pizzaRepository.writeInPizzasInMarket(marketPizzas);
    _pizzaRepository.writeInPizzasInBasket(basketPizzas);

    emit(
      state.copyWith(
          pizzasInMarket: marketPizzas.getPizzas,
          pizzasInBasket: basketPizzas.getPizzaInBasket),
    );
  }

  _getPizzaMockForMarketInAdmin(
    GetPizzaMocksForMarketInAdminEvent event,
    Emitter<PizzaState> emit,
  ) async {
    List<Pizza> pizzas = state.pizzaInAdmin;
    emit(
      state.copyWith(pizzaInAdmin: pizzas),
    );
  }

  _addPizzaMockForMarketInAdmin(
    AddPizzaMockForMarketInAdminEvent event,
    Emitter<PizzaState> emit,
  ) async {
    List<Pizza> pizzas = state.pizzaInAdmin;
    Pizza mockPizza = Pizza(namePizza: '', pricePizza: '', countPizza: 1);
    pizzas = List.from(pizzas)..add(mockPizza);
    emit(
      state.copyWith(
        pizzaInAdmin: pizzas,
      ),
    );
  }

  _setCountPizzaMockForMarketInAdmin(
    SetCountPizzaMockForMarketInAdminEvent event,
    Emitter<PizzaState> emit,
  ) async {
    List<Pizza> pizzas = state.pizzaInAdmin;
    pizzas[event.position].countPizza = event.count;
    emit(
      state.copyWith(pizzaInAdmin: pizzas),
    );
  }

  _clearAllPizzaMocksForMarketInAdminEvent(
    ClearAllPizzaMocksForMarketInAdminEvent event,
    Emitter<PizzaState> emit,
  ) async {
    emit(
      state.copyWith(pizzaInAdmin: []),
    );
  }

  _addPizzaInMarketEvent(
    AddPizzaInMarketEvent event,
    Emitter<PizzaState> emit,
  ) async {
    List<Pizza> pizzasInAdmin = state.pizzaInAdmin;
    PizzaListModel pizzas = await _pizzaRepository.getPizzasForMarket();
    pizzas.getPizzas.addAll(pizzasInAdmin);
    await _pizzaRepository.writeInPizzasInMarket(pizzas);
    emit(
      state.copyWith(pizzasInMarket: pizzasInAdmin),
    );
  }

  _setNameOnPizzasMockInAdmin(
    SetNameOnPizzaMockInAdminEvent event,
    Emitter<PizzaState> emit,
  ) async {
    List<Pizza> pizzasInAdmin = state.pizzaInAdmin;
    pizzasInAdmin[event.position].namePizza = event.name;
    emit(
      state.copyWith(pizzaInAdmin: pizzasInAdmin),
    );
  }

  _setPriceOnPizzaMockInAdmin(
    SetPriceOnPizzaMockInAdminEvent event,
    Emitter<PizzaState> emit,
  ) async {
    List<Pizza> pizzasInAdmin = state.pizzaInAdmin;
    pizzasInAdmin[event.position].pricePizza = event.price;
    emit(
      state.copyWith(pizzaInAdmin: pizzasInAdmin),
    );
  }

  _clearAllPizzasInBasket(
    ClearAllPizzasInBasket event,
    Emitter<PizzaState> emit,
  ) async {
    ShoppingBasketModel pizzas = await _pizzaRepository.getPizzasForBasket();
    pizzas.getPizzaInBasket.clear();
    await _pizzaRepository.writeInPizzasInBasket(pizzas);
    emit(
      state.copyWith(pizzasInBasket: pizzas.getPizzaInBasket),
    );
  }

  _sortByPriceASC(
    SortByPriceASC event,
    Emitter<PizzaState> emit,
  ) async {
    PizzaListModel pizzas = await _pizzaRepository.getPizzasForMarket();
    pizzas.getPizzas.sort(
      (a, b) => a.pricePizza.compareTo(b.pricePizza),
    );
    await _pizzaRepository.writeInPizzasInMarket(pizzas);
    emit(
      state.copyWith(pizzasInMarket: pizzas.getPizzas),
    );
  }

  _sortByPriceDESC(
    SortByPriceDESC event,
    Emitter<PizzaState> emit,
  ) async {
    PizzaListModel pizzas = await _pizzaRepository.getPizzasForMarket();
    pizzas.getPizzas.sort(
      (a, b) => b.pricePizza.compareTo(a.pricePizza),
    );
    await _pizzaRepository.writeInPizzasInMarket(pizzas);
    emit(
      state.copyWith(pizzasInMarket: pizzas.getPizzas),
    );
  }

  _searchPizza(
    SearchPizza event,
    Emitter<PizzaState> emit,
  ) async {
    if (event.query.isEmpty) return;
    List<Pizza> pizzas = await _pizzaRepository.searchPizza(event.query);
    emit(
      state.copyWith(pizzasInMarket: pizzas),
    );
  }
}
