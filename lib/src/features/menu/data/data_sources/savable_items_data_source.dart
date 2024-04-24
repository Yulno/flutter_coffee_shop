import 'package:drift/drift.dart';
import 'package:flutter_coffee_shop/src/features/menu/data/data_base/database.dart';
import 'package:flutter_coffee_shop/src/features/menu/data/data_sources/items_data_source.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/dto/category_dto.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/dto/item_dto.dart';

abstract interface class ISavableItemsDataSource implements IItemsDataSource {
  Future<void> saveItems({required List<ItemDto> items});
}

final class DbItemsDataSource implements ISavableItemsDataSource {
  final AppDatabase _db;

  const DbItemsDataSource({required AppDatabase db}) : _db = db;

  @override
  Future<List<ItemDto>> fetchItems({
    required int categoryId,
    int page = 0,
    int limit = 25,
  }) async {
    List<ItemDto> data = [];
    int offset = limit * page;
    final items = await (_db.select(_db.items)
          ..where((u) => u.categoryId.equals(categoryId))
          ..limit(limit, offset: offset))
        .get();
    for (var item in items) {
      final category = await (_db.select(_db.categories)
            ..where((u) => u.id.equals(item.categoryId)))
          .getSingle();
      data.add(
        ItemDto(
          id: item.id,
          name: item.name,
          description: item.description,
          icon: item.icon,
          price: item.price,
          category: CategoryDto(
            id: category.id,
            slug: category.slug,
          ),
        ),
      );
    }
    return data;
  }

  @override
  Future<void> saveItems({required List<ItemDto> items}) async {
    for (var item in items) {
      _db.into(_db.items).insertOnConflictUpdate(
            ItemsCompanion.insert(
              id: Value(item.id),
              name: item.name,
              description: item.description,
              icon: item.icon,
              price: item.price,
              categoryId: item.category.id,
            ),
          );
    }
  }

  @override
  Future<ItemDto> fetchItem({required int itemId}) async {
    final item = await (_db.select(_db.items)
          ..where((u) => u.id.equals(itemId)))
        .getSingle();
    final category = await (_db.select(_db.categories)
          ..where((e) => e.id.equals(item.categoryId)))
        .getSingle();
    return ItemDto(
      id: item.id,
      name: item.name,
      description: item.description,
      icon: item.icon,
      price: item.price,
      category: CategoryDto(
        id: category.id,
        slug: category.slug,
      ),
    );
  }
}
