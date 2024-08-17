import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice_app/bloc/theme/theme_event.dart';
import 'package:flutter_practice_app/bloc/theme/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(themeMode: ThemeMode.light)) {
    on<ThemeToggel>(_themeToggel);
  }

  void _themeToggel(ThemeToggel event, Emitter<ThemeState> emit) {
    final isLightTheme = state.themeMode == ThemeMode.light;
    emit(state.copyWith(
        themeMode: isLightTheme ? ThemeMode.dark : ThemeMode.light));
  }
}
