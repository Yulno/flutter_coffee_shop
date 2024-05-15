import 'package:flutter_coffee_shop/src/features/menu/models/category_model.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/dto/category_dto.dart';

extension CategoryMapper on CategoryDto {
  CategoryModel toModel() => CategoryModel(
        id: id,
        slug: slug,
      );
}