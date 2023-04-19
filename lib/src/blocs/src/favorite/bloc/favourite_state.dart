// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'favourite_bloc.dart';

enum FavouriteStatus { initial, userExist, userRemoved, userAdded, cleared }

class FavouriteState extends Equatable {
  final FavouriteStatus favouriteStatus;
  final List<User> users;

  FavouriteState({
    this.favouriteStatus = FavouriteStatus.initial,
    this.users = const [],
  });

  @override
  List<Object> get props => [users, favouriteStatus];

  bool userInFavourite(User user) {
    return users.contains(user);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'favouriteStatus': favouriteStatus.name,
      'users': users.map((x) => x.toMap()).toList(),
    };
  }

  factory FavouriteState.fromMap(Map<String, dynamic> map) {
    return FavouriteState(
      favouriteStatus:
          FavouriteStatus.values.byName(map['favouriteStatus'] as String),
      users: List<User>.from(
        (map['users'] as List<Map<String, dynamic>>).map<User>(
          (x) => User.fromMap(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory FavouriteState.fromJson(String source) =>
      FavouriteState.fromMap(json.decode(source) as Map<String, dynamic>);

  FavouriteState copyWith({
    FavouriteStatus? favouriteStatus,
    List<User>? users,
  }) {
    return FavouriteState(
      favouriteStatus: favouriteStatus ?? this.favouriteStatus,
      users: users ?? this.users,
    );
  }
}
