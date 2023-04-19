part of 'favourite_bloc.dart';

abstract class FavouriteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavouriteUserAdded extends FavouriteEvent {
  final User user;
  FavouriteUserAdded({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}

class FavouriteUserRemoved extends FavouriteEvent {
  final User user;
  FavouriteUserRemoved({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}

class ClearedFavourite extends FavouriteEvent {}
