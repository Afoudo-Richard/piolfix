part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class IsDarkModeChanged extends SettingsEvent {
  final bool value;
  IsDarkModeChanged({required this.value});
}
