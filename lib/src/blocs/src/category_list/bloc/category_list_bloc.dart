import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:poilfix/poilfix.dart';
import 'dart:convert';

part 'category_list_event.dart';
part 'category_list_state.dart';

const _duration = Duration(milliseconds: 300);

class CategoryListBloc
    extends HydratedBloc<CategoryListEvent, CategoryListState> {
  CategoryListBloc() : super(CategoryListState()) {
    on<CategoryListFetched>(_onCategoryListFetched);
    on<CategoryListSearchChanged>(_onCategoryListSearchChanged);
  }

  Future<void> _onCategoryListFetched(
    CategoryListFetched event,
    Emitter<CategoryListState> emit,
  ) async {
    if (!event.refresh) {
      if (state.hasReachedMax) return;
    } else {
      emit(state.copyWith(
        categoryListStatus: CategoryListStatus.initial,
      ));
    }

    try {
      final categories = await _fetchBrands();

      return emit(
        state.copyWith(
          categoryListStatus: CategoryListStatus.success,
          categories: categories,
          categoriesCopy: categories,
          hasReachedMax: true,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        categoryListStatus: CategoryListStatus.failure,
      ));
    }
  }

  void _onCategoryListSearchChanged(
    CategoryListSearchChanged event,
    Emitter<CategoryListState> emit,
  ) async {
    if (event.text.isEmpty) {
      return emit(
        state.copyWith(
          categoriesCopy: state.categories,
        ),
      );
    }
    final category = state.categories
        .where(
          (category) =>
              category.name!.toLowerCase().contains(event.text.toLowerCase()),
        )
        .toList();

    emit(
      state.copyWith(
        categoriesCopy: category,
      ),
    );
  }

  Future<List<Category>> _fetchBrands() async {
    QueryBuilder<Category> query = QueryBuilder(Category());
    return query.find();
  }

  @override
  CategoryListState? fromJson(Map<String, dynamic> json) {
    return CategoryListState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(CategoryListState state) {
    return state.toMap();
  }
}
