import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class TxtColorState extends Equatable {
  TxtColorState({this.color = Colors.deepPurple});

  Color color;

  @override
  List<Object> get props => [color];

  TxtColorState copyWith({Color? color}){
    return TxtColorState(color: color ?? this.color);
  }
}