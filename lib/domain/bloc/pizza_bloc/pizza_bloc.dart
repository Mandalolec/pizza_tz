import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_tz/data/model/pizza.dart';
import 'package:pizza_tz/domain/repository/pizza_repository.dart';

part 'pizza_event.dart';
part 'pizza_state.dart';

class PizzaBloc extends Bloc<PizzaEvent, PizzaState> {
  final PizzaRepository pizzaRepository;

  PizzaBloc(super.initialState, {
    required this.pizzaRepository
  }) {
    on<PizzaLoadEvent>(mapEventToState);
  }

  get initialState => PizzaInitialState();


  Stream<PizzaState> mapEventToState(event, emit) async* {
    try {
      yield PizzaLoadingState();
      final pizzas = await pizzaRepository.readPizzaList();
      yield PizzaLoadedState(pizzaList: pizzas.getPizzas);
    } catch (error) {
      yield PizzaErrorState();
    }
  }
}
