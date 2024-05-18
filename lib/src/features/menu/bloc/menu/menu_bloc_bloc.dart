import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_coffee_shop/src/features/menu/data/item_repository.dart';
import 'package:flutter_coffee_shop/src/features/menu/data/category_repository.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/category_model.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'menu_bloc_event.dart';
part 'menu_bloc_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc(
    this._itemsRepository,
    this._categoriesRepository,
    
  ) : super(
          const MenuState(
            status: MenuStatus.idle,
            products: [],
            categories: [],
          ),
        ) {
    on<LoadCategoryEvent>(_loadCategory);
    on<LoadPageEvent>(_loadPage);
    on<LoadItemEvent>(_loadItem);
  }


  final ICategoriesRepository _categoriesRepository;
  final IItemsRepository _itemsRepository;

  CategoryModel? _currentPaginatedCategory;
  int _currentPage = 0;

  final int _pageLimit = 25;

  Future<void> _loadCategory(event, emit) async {
    emit(state.copyWith(products: state.products, status: MenuStatus.loading));
    try {
      final categories = await _categoriesRepository.loadCategories();
      emit(
        state.copyWith(
          categories: categories,
          products: List.empty(),
          status: MenuStatus.success,
        ),
      );
      add(
        const LoadPageEvent(),
      );
    } on Object {
      emit(
        state.copyWith(
          categories: state.categories,
          products: state.products,
          status: MenuStatus.error,
        ),
      );
      rethrow;
    } finally {
      emit(
        state.copyWith(
          categories: state.categories,
          products: state.products,
          status: MenuStatus.idle,
        ),
      );
    }
  }

 Future<void> _loadItem(event, emit) async {
    CategoryModel? currentCategory = event.category as CategoryModel?;
    if (currentCategory == null) return;
    emit(
      state.copyWith(products: state.products, status: MenuStatus.loading),
    );
    final List<ItemModel> previousItems = List<ItemModel>.from(state.products);
    try {
      final products = await _itemsRepository.loadItems(
        category: currentCategory,
        limit: _pageLimit,
      );
      previousItems.addAll(products);
      emit(
        state.copyWith(
          categories: state.categories,
          products: previousItems,
          status: MenuStatus.success,
        ),
      );
    } on Object {
      emit(
        state.copyWith(
          categories: state.categories,
          products: state.products,
          status: MenuStatus.error,
        ),
      );
      rethrow;
    } finally {
      emit(
        state.copyWith(
          categories: state.categories,
          products: previousItems,
          status: MenuStatus.idle,
        ),
      );
    }
  }

  Future<void> _loadPage(event, emit) async {
    List<CategoryModel>? categories = state.categories;
    if (categories.isEmpty) return;
    CategoryModel? currentCategory = _currentPaginatedCategory;
    currentCategory ??= categories.first;
    emit(
      state.copyWith(products: state.products, status: MenuStatus.loading),
    );
    try {
      final List<ItemModel> previousItems = List<ItemModel>.from(state.products);
      final products = await _itemsRepository.loadItems(
        category: currentCategory,
        page: _currentPage,
        limit: _pageLimit,
      );
      _currentPage += 1;
      if (products.length < _pageLimit) {
        if (currentCategory != categories.last) {
          int nextPaginatedCategoryIndex =
              categories.indexOf(currentCategory) + 1;
          currentCategory = categories[nextPaginatedCategoryIndex];
          _currentPage = 0;
        }
      }
      _currentPaginatedCategory = currentCategory;
      previousItems.addAll(products);
      emit(
        state.copyWith(
          categories: state.categories,
          products: previousItems,
          status: MenuStatus.success,
        ),
      );
    } on Object {
      emit(
        state.copyWith(
          categories: state.categories,
          products: state.products,
          status: MenuStatus.error,
        ),
      );
      rethrow;
    } finally {
      emit(
        state.copyWith(
          categories: state.categories,
          products: state.products,
          status: MenuStatus.idle,
        ),
      );
    }
  }
}
