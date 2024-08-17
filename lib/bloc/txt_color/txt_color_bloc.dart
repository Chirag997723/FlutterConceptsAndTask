import 'package:bloc/bloc.dart';
import 'package:flutter_practice_app/bloc/txt_color/txt_color_event.dart';
import 'package:flutter_practice_app/bloc/txt_color/txt_color_state.dart';

class TxtColorBloc extends Bloc<TxtColorEvent, TxtColorState>{
  TxtColorBloc(): super(TxtColorState()){
    on<TextColorChange>(_textColorChange);
  }

  void _textColorChange(TextColorChange event, Emitter<TxtColorState> emit){
    emit(state.copyWith(color: event.color));
  }
}