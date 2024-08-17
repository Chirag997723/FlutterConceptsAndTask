import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TxtColorEvent extends Equatable {
  const TxtColorEvent();

  @override
  List<Object> get props => [];
}

class TextColorChange extends TxtColorEvent{
  const TextColorChange({required this.color});

  final Color color;

  @override
  List<Object> get props => [color];
}