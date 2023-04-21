// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final bool isDarkMode;
  final Locale locale;

  const SettingsState({
    this.isDarkMode = false,
    this.locale = const Locale('en', 'US'),
  });

  @override
  List<Object> get props => [
        isDarkMode,
        locale,
      ];

  SettingsState copyWith({
    bool? isDarkMode,
    Locale? locale,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      locale: locale ?? this.locale,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isDarkMode': isDarkMode,
      'locale': locale.toString()
    };
  }

  factory SettingsState.fromMap(Map<String, dynamic> map) {
    return SettingsState(
      isDarkMode: map['isDarkMode'] as bool,
      locale: map['locale'] != null
          ? Locale(
              map['locale'].toString().split('_')[0],
              map['locale'].toString().split('_')[1],
            )
          : const Locale('en', 'US'),
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingsState.fromJson(String source) =>
      SettingsState.fromMap(json.decode(source) as Map<String, dynamic>);
}
