import 'package:flutter_coffee_shop/src/features/menu/models/coffee_title_model.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/dto/menu_category_dto.dart';

extension CategoryMapper on MenuCategoryDto {
  CategoryModel toModel() {
    return const CategoryModel();
  }
}