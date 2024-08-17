import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice_app/bloc/switch/switch_event.dart';
import 'package:flutter_practice_app/bloc/switch/switch_state.dart';

class SwitchBloc extends Bloc<SwitchEvent, SwitchState> {
  SwitchBloc():super(SwitchState()){
    on<ToggelNotifi>(_toggelNotifi);
    on<SliderEvent>(_slider);
  }

  void _toggelNotifi(ToggelNotifi event, Emitter<SwitchState> emit){
    emit(state.copyWith(isSwitch: !state.isSwitch));
  }

  void _slider(SliderEvent event, Emitter<SwitchState> emit){
    emit(state.copyWith(slider: event.slider));
  }
}