import 'package:flutter_coffee_shop/src/features/menu/models/dto/menu_category_dto.dart';

abstract interface class ICategoriesDataSource {
  Future<List<MenuCategoryDto>> fetchCategories();
}

final class NetworkCategoriesDataSource implements ICategoriesDataSource {
  // Put dependency of network class such as dio or http, e.g.
  // final Dio _dio;

  const NetworkCategoriesDataSource(/*{required Dio dio}*/)/* : _dio = dio*/;

  @override
  Future<List<MenuCategoryDto>> fetchCategories() {
    // TODO: implement fetchCategories
    throw UnimplementedError();
  }
}