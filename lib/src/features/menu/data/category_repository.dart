import 'dart:io';

import 'package:flutter_coffee_shop/src/features/menu/data/data_sources/categories_data_source.dart';
import 'package:flutter_coffee_shop/src/features/menu/data/data_sources/savable_categories_data_source.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/category_model.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/dto/category_dto.dart';
import 'package:flutter_coffee_shop/src/features/menu/utils/category_mapper.dart';

abstract interface class ICategoriesRepository {
  Future<List<CategoryModel>> loadCategories();
}

final class CategoriesRepository implements ICategoriesRepository {
  final ICategoriesDataSource _networkCategoriesDataSource;
  final ISavableCategoriesDataSource _dbCategoriesDataSource;

  const CategoriesRepository({
    required ICategoriesDataSource networkCategoriesDataSource, 
    required ISavableCategoriesDataSource dbCategoriesDataSource,
  }) : _networkCategoriesDataSource = networkCategoriesDataSource,
      _dbCategoriesDataSource = dbCategoriesDataSource;

  @override
  Future<List<CategoryModel>> loadCategories() async {
    var dtos = <CategoryDto>[];
    try {
      dtos = await _networkCategoriesDataSource.fetchCategories();
      _dbCategoriesDataSource.saveCategories(categories: dtos);
    } on SocketException {
      dtos = await _dbCategoriesDataSource.fetchCategories();
    }
    return dtos.map((e) => e.toModel()).toList();
  }
}