import 'package:drift/drift.dart';
import 'package:flutter_coffee_shop/src/common/data_base/database.dart';
import 'package:flutter_coffee_shop/src/features/menu/data/data_sources/categories_data_source.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/dto/category_dto.dart';

abstract interface class ISavableCategoriesDataSource implements ICategoriesDataSource {
  Future<void> saveCategories({required List<CategoryDto> categories});
}

final class DbCategoriesDataSource implements ISavableCategoriesDataSource {
  final AppDatabase _db;

  const DbCategoriesDataSource({required AppDatabase db}) : _db = db;

  @override
  Future<List<CategoryDto>> fetchCategories() async {
    final result = await (_db.select(_db.categories)).get();
    return List<CategoryDto>.of(result.map((e) => CategoryDto(id: e.id, slug: e.slug)));
  }

  @override
  Future<void> saveCategories({required List<CategoryDto> categories}) async {
    for (var category in categories) {
      _db.into(_db.categories).insertOnConflictUpdate(
        CategoriesCompanion.insert(id: Value(category.id), slug: category.slug,),
      );
    }
  }
}
