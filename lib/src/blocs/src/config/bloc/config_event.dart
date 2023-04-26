part of 'config_bloc.dart';

abstract class ConfigEvent extends Equatable {
  ConfigEvent();

  @override
  List<Object> get props => [];
}

class ConfigChanged extends ConfigEvent {}

class ConfigFetched extends ConfigEvent {
  final bool refresh;
  ConfigFetched({this.refresh = false});
}
