part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final bool isDarkMode;

  const SettingsState({this.isDarkMode = false});

  @override
  List<Object> get props => [isDarkMode];

  SettingsState copyWith({
    bool? isDarkMode,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isDarkMode': isDarkMode,
    };
  }

  factory SettingsState.fromMap(Map<String, dynamic> map) {
    return SettingsState(
      isDarkMode: map['isDarkMode'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingsState.fromJson(String source) =>
      SettingsState.fromMap(json.decode(source) as Map<String, dynamic>);
}
