part of 'category_add_bloc.dart';

abstract class CategoryAddEvent extends Equatable {
  const CategoryAddEvent();
  @override
  List<Object> get props => [];
}

class CategoryAddImageSelected extends CategoryAddEvent {}

class CategoryAddNameChanged extends CategoryAddEvent {
  const CategoryAddNameChanged(this.value);

  final String value;
  @override
  List<Object> get props => [value];
}

class CategoryAddPhotoCleared extends CategoryAddEvent {}

class SubmitCategoryAddInputsChecked extends CategoryAddEvent {}

class CategoryAddSubmitted extends CategoryAddEvent {}
