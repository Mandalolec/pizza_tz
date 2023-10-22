part of 'counter_purchase_bloc.dart';

abstract class CounterEvent {}

class CounterInitEvent extends CounterEvent {}

class CounterIncrementEvent extends CounterEvent {}

class CounterDecrementEvent extends CounterEvent {}