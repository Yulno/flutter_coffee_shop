import 'package:flutter_coffee_shop/src/features/menu/models/item_model.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/dto/item_dto.dart';
import 'package:flutter_coffee_shop/src/features/menu/utils/category_mapper.dart';

extension ItemMapper on ItemDto {
  ItemModel toModel() => ItemModel(
        id: id,
        name: name,
        price: price,
        icon: icon,
        description: description,
        category: category.toModel(),
      );
}