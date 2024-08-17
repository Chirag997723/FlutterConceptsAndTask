import 'package:bloc/bloc.dart';
import 'package:flutter_practice_app/bloc/counter/counter_event.dart';
import 'package:flutter_practice_app/bloc/counter/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterSatet> {
  CounterBloc() : super(const CounterSatet()) {
    on<IncrementCounter>(_increment);
    on<DecrementCounter>(_decrement);
  }

  void _increment(IncrementCounter event, Emitter<CounterSatet> emit) {
    emit(state.copyWith(counter: state.counter + 1));
  }
  void _decrement(DecrementCounter event, Emitter<CounterSatet> emit) {
    emit(state.copyWith(counter: state.counter - 1));
  }
}
