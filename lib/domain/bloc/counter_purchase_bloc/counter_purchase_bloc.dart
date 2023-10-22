import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_purchase_event.dart';
part 'counter_purchase_state.dart';

class CounterPurchaseBloc extends Bloc<CounterEvent, CounterState> {
  final int count;

  CounterPurchaseBloc(this.count) : super(CounterState()) {
    on<CounterInitEvent>(_onInit);
    on<CounterIncrementEvent>(_onIncrement);
    on<CounterDecrementEvent>(_onDecrement);
  }

  _onInit(CounterEvent event, Emitter<CounterState> emit) {
    emit(state.copyWith(count: count));
  }

  _onIncrement(CounterIncrementEvent event, Emitter<CounterState> emit) {
    emit(state.copyWith(count: state.increment()));
  }

  _onDecrement(CounterDecrementEvent event, Emitter<CounterState> emit) {
    if (state.count <= 1) return;
    emit(state.copyWith(count: state.decrement()));
  }
}



