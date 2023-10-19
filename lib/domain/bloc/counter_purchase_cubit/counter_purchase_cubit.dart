import 'package:flutter_bloc/flutter_bloc.dart';


class CounterPurchaseCubit extends Cubit<int> {
  CounterPurchaseCubit() : super(1);

  void increment() => emit(state + 1);

  void decrement() {
    if (state <= 1) return;

    emit(state - 1);
  }
}
