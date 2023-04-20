// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

enum UserAvailableStatus { initial, success, loading, failure }

class UserState extends Equatable {
  final User? user;
  final bool checker;
  final Locale locale;
  final UserAvailableStatus userAvailableStatus;

  UserState({
    this.user,
    this.checker = false,
    this.locale = const Locale('en', 'US'),
    this.userAvailableStatus = UserAvailableStatus.initial,
  });

  @override
  List<Object?> get props => [
        user,
        userAvailableStatus,
        checker,
      ];

  UserState copyWith({
    User? user,
    bool? checker,
    Locale? locale,
    bool? isAvailable,
    UserAvailableStatus? userAvailableStatus,
  }) {
    return UserState(
      user: user ?? this.user,
      checker: checker ?? this.checker,
      locale: locale ?? this.locale,
      userAvailableStatus: userAvailableStatus ?? this.userAvailableStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user?.toMap(),
    };
  }

  factory UserState.fromMap(Map<String, dynamic> map) {
    return UserState(
      user: map['user'] != null
          ? User.fromMap(map['user'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserState.fromJson(String source) =>
      UserState.fromMap(json.decode(source) as Map<String, dynamic>);
}
