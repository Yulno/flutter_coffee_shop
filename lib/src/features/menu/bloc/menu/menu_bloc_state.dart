part of 'menu_bloc_bloc.dart';

enum MenuStatus { loading, success, error, idle }

final class MenuState extends Equatable {
  final MenuStatus status;
  final List<CategoryModel>? categories;
  final List<CoffeeCardModel>? items;

  const MenuState({this.categories, this.items, required this.status});


  MenuState copyWith({
    List<CategoryModel>? categories,
    List<CoffeeCardModel>? items,
    MenuStatus? status,
  }) {
    return MenuState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      items: items ?? this.items,
    );
  }

  @override
  String toString() {
    return '''MenuStatus { status: $status, categories: ${categories?.length}, items: ${items?.length} }''';
  }

  @override
  List<Object?> get props => [status, categories, items];
}