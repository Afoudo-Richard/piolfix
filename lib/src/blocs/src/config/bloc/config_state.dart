part of 'config_bloc.dart';

enum ConfigListStatus { initial, loading, success, failure, refresh }

class ConfigState extends Equatable {
  final String privacyPolicy;
  final String termsAndCondition;
  final ConfigListStatus configListStatus;
  final String? errorMessage;

  const ConfigState({
    this.privacyPolicy = '',
    this.termsAndCondition = '',
    this.configListStatus = ConfigListStatus.initial,
    this.errorMessage,
  });

  @override
  List<Object> get props => [privacyPolicy, termsAndCondition];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'privacyPolicy': privacyPolicy,
      'termsAndCondition': termsAndCondition,
      'configListStatus': configListStatus.name,
      'errorMessage': errorMessage,
    };
  }

  factory ConfigState.fromMap(Map<String, dynamic> map) {
    return ConfigState(
      privacyPolicy: map['privacyPolicy'] as String,
      termsAndCondition: map['termsAndCondition'] as String,
      configListStatus:
          ConfigListStatus.values.byName(map['configListStatus'] as String),
      errorMessage:
          map['errorMessage'] != null ? map['errorMessage'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConfigState.fromJson(String source) =>
      ConfigState.fromMap(json.decode(source) as Map<String, dynamic>);

  ConfigState copyWith({
    String? privacyPolicy,
    String? termsAndCondition,
    ConfigListStatus? configListStatus,
    String? errorMessage,
  }) {
    return ConfigState(
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      termsAndCondition: termsAndCondition ?? this.termsAndCondition,
      configListStatus: configListStatus ?? this.configListStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
