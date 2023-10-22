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
    on<PizzaLoadEvent>(
      _getPizza,
      transformer: debounceDroppable(
        const Duration(microseconds: 300),
      ),
    );
  }

  late final PizzaFromLocalJsonFileRepository _pizzaRepository;

  _getPizza(PizzaLoadEvent event, Emitter<PizzaState> emit) async {
    final pizzas = await _pizzaRepository.readPizzaList();
    emit(PizzaState(pizzas: pizzas.getPizzas));
  }
}
