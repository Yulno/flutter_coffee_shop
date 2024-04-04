import 'package:flutter_coffee_shop/src/features/menu/data/data_sources/categories_data_source.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/dto/menu_category_dto.dart';

abstract interface class ISavableCategoriesDataSource implements ICategoriesDataSource {
  Future<void> saveCategories({required List<MenuCategoryDto> categories});
} 

final class DbCategoriesDataSource implements ISavableCategoriesDataSource {
  // Put dependency of network class such as dio or http, e.g.
  // final IMenuDb _menuDb;

  const DbCategoriesDataSource(/*{required IMenuDb menuDb}*/)/* : _menuDb = menuDb*/;

  @override
  Future<List<MenuCategoryDto>> fetchCategories() {
    // TODO: implement fetchCategories
    throw UnimplementedError();
  }

  @override
  Future<void> saveCategories({required List<MenuCategoryDto> categories}) {
    // TODO: implement saveCategories
    throw UnimplementedError();
  }
}