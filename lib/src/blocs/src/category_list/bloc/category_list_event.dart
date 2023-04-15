part of 'category_list_bloc.dart';

abstract class CategoryListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoryListChanged extends CategoryListEvent {}

class CategoryListFetched extends CategoryListEvent {
  final bool refresh;
  CategoryListFetched({this.refresh = false});
}

class CategoryListSearchChanged extends CategoryListEvent {
  final String text;
  CategoryListSearchChanged({required this.text});
}
