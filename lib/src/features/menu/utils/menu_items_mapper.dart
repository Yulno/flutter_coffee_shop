import 'package:flutter_coffee_shop/src/features/menu/models/coffee_card_model.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/dto/menu_item_dto.dart';

extension MenuItemsMapper on MenuItemDto {
  CoffeeCardModel toModel() {
    return const CoffeeCardModel();
  }
}