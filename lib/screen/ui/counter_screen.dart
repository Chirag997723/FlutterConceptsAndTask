import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice_app/bloc/counter/counter_bloc.dart';
import 'package:flutter_practice_app/bloc/counter/counter_event.dart';
import 'package:flutter_practice_app/bloc/counter/counter_state.dart';

class CounterScreen extends StatefulWidget {
  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('BlocEx'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<CounterBloc, CounterSatet>(
            builder: (context, state) {
              return Center(
                child: Text(
                  state.counter.toString(),
                  style: TextStyle(fontSize: 60),
                ),
              );
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {
                context.read<CounterBloc>().add(IncrementCounter());
              }, child: const Text('Increment')),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(onPressed: () {
                context.read<CounterBloc>().add(DecrementCounter());
              }, child: const Text('Decrement')),
            ],
          ),
        ],
      ),
    );
  }
}
