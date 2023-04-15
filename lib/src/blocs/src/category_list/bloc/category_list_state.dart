part of 'category_list_bloc.dart';

enum CategoryListStatus { initial, success, failure, refresh }

class CategoryListState extends Equatable {
  final List<Category> categories;
  final List<Category> categoriesCopy;
  final CategoryListStatus categoryListStatus;
  final bool hasReachedMax;

  CategoryListState({
    this.categories = const <Category>[],
    this.categoriesCopy = const <Category>[],
    this.categoryListStatus = CategoryListStatus.initial,
    this.hasReachedMax = false,
  });

  @override
  List<Object> get props =>
      [categories, categoriesCopy, categoryListStatus, hasReachedMax];

  CategoryListState copyWith({
    List<Category>? categories,
    List<Category>? categoriesCopy,
    CategoryListStatus? categoryListStatus,
    bool? hasReachedMax,
  }) {
    return CategoryListState(
      categories: categories ?? this.categories,
      categoriesCopy: categoriesCopy ?? this.categoriesCopy,
      categoryListStatus: categoryListStatus ?? this.categoryListStatus,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categories': categories.map((x) => x.toMap()).toList(),
      'categoriesCopy': categoriesCopy.map((x) => x.toMap()).toList(),
      'categoryListStatus': categoryListStatus.name,
      'hasReachedMax': hasReachedMax,
    };
  }

  factory CategoryListState.fromMap(Map<String, dynamic> map) {
    return CategoryListState(
      categories: List<Category>.from(
        (map['categories'] as List<dynamic>).map<Category>(
          (x) => Category.fromMap(x as Map<String, dynamic>),
        ),
      ),
      categoriesCopy: List<Category>.from(
        (map['categoriesCopy'] as List<dynamic>).map<Category>(
          (x) => Category.fromMap(x as Map<String, dynamic>),
        ),
      ),
      categoryListStatus:
          CategoryListStatus.values.byName(map['categoryListStatus'] as String),
      hasReachedMax: map['hasReachedMax'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryListState.fromJson(String source) =>
      CategoryListState.fromMap(json.decode(source) as Map<String, dynamic>);
}
