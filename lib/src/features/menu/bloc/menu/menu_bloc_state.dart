part of 'menu_bloc_bloc.dart';

enum MenuStatus { loading, success, error, idle }

final class MenuState extends Equatable {
  final MenuStatus status = MenuStatus.idle;
  final List<CategoryModel> categories;
  final List<ItemModel> products;

  const MenuState({required this.categories, required this.products,  required MenuStatus status,});

  MenuState copyWith({
    List<CategoryModel>? categories,
    List<ItemModel>? products,
    MenuStatus? status,
  }) {
    return MenuState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      products: products ?? this.products,
    );
  }

  @override
  String toString() {
    return '''MenuStatus { status: $status, categories: ${categories.length}, products: ${products.length} }''';
  }

  @override
  List<Object?> get props => [status, categories, products];
}
