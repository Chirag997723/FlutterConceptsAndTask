import 'package:equatable/equatable.dart';

class CounterSatet extends Equatable {
  final int counter;

  const CounterSatet({this.counter = 0});

  CounterSatet copyWith({int? counter}) {
    return CounterSatet(counter: counter ?? this.counter);
  }

  @override
  List<Object?> get props => [counter];
}
