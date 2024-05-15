import 'dart:io';

import 'package:flutter_coffee_shop/src/features/menu/data/data_sources/items_data_source.dart';
import 'package:flutter_coffee_shop/src/features/menu/data/data_sources/savable_items_data_source.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/category_model.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/dto/item_dto.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/item_model.dart';
import 'package:flutter_coffee_shop/src/features/menu/utils/item_mapper.dart';

abstract interface class IItemsRepository {
  Future<List<ItemModel>> loadItems({
    required CategoryModel category,
    int page = 0,
    int limit = 25,
  });
}

final class ItemsRepository implements IItemsRepository {
  final IItemsDataSource _networkItemsDataSource;
  final ISavableItemsDataSource _dbItemsDataSource;

  const ItemsRepository({
    required IItemsDataSource networkItemsDataSource,
    required ISavableItemsDataSource dbItemsDataSource,
  })  : _networkItemsDataSource = networkItemsDataSource,
        _dbItemsDataSource = dbItemsDataSource;

  @override
  Future<List<ItemModel>> loadItems({
    required CategoryModel category,
    int page = 0,
    int limit = 25,
  }) async {
    var dtos = <ItemDto>[];
    try {
      dtos = await _networkItemsDataSource.fetchItems(
        categoryId: category.id,
        page: page,
        limit: limit,
      );
      _dbItemsDataSource.saveItems(items: dtos);
    } on SocketException {
      dtos = await _dbItemsDataSource.fetchItems(
        categoryId: category.id,
        page: page,
        limit: limit,
      );
    }
    return dtos.map((e) => e.toModel()).toList();
  }
}
