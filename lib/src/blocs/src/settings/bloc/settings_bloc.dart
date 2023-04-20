import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<IsDarkModeChanged>(_isDarkModeChanged);
    on<LanguageChanged>(_onLanguageChanged);
  }

  void _isDarkModeChanged(
    IsDarkModeChanged event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(isDarkMode: event.value));
  }

  void _onLanguageChanged(
    LanguageChanged event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(locale: event.value));
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    return SettingsState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    return state.toMap();
  }
}
