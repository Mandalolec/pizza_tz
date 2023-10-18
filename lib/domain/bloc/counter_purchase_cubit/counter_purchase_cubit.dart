import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


class CounterPurchaseCubit extends Cubit<int> {
  CounterPurchaseCubit() : super(1);

  void increment() => emit(state + 1);

  void decrement() {
    if (state <= 1) return;

    emit(state - 1);
  }
}
