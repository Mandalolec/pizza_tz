part of 'counter_purchase_bloc.dart';

class CounterState {
  final int count;

  int increment() {
    return count + 1;
  }

  int decrement() {
    return count - 1;
  }

  CounterState({
    this.count = 1,
  });

  CounterState copyWith({
    int? count,
  }) {
    return CounterState(
      count: count ?? this.count,
    );
  }
}
