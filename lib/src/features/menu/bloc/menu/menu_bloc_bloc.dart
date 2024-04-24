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
  MenuBloc(this._categoriesRepository, this._itemsRepository,)
      : super(
          const MenuState(
            status: MenuStatus.idle,
            items: [],
            categories: [],
          ),
        ) {
    on<LoadCategoryEvent>(_loadCategory);
    on<LoadPageEvent>(_loadPage);
  }

  final ICategoriesRepository _categoriesRepository;
  final IItemsRepository _itemsRepository;

  CategoryModel? _currentPaginatedCategory;
  int _currentPage = 0;

  final int _pageLimit = 25;

  Future<void> _loadCategory(event, emit) async {
    emit(state.copyWith(items: state.items, status: MenuStatus.loading));
    try {
      final categories = await _categoriesRepository.loadCategories();
      emit(
        state.copyWith(
          categories: categories,
          items: List.empty(),
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
          items: state.items,
          status: MenuStatus.error,
        ),
      );
      rethrow;
    } finally {
      emit(
        state.copyWith(
          categories: state.categories,
          items: state.items,
          status: MenuStatus.idle,
        ),
      );
    }
  }

  Future<void> _loadPage(event, emit) async {
    List<CategoryModel>? categories = state.categories;
    if (categories!.isEmpty) return;
    CategoryModel? currentCategory = _currentPaginatedCategory;
    currentCategory ??= categories.first;
    emit(
      state.copyWith(items: state.items, status: MenuStatus.loading),
    );
    try {
      final List<ItemModel> previousItems =
          List<ItemModel>.from(state.items!);
      final items = await _itemsRepository.loadItems(
        category: currentCategory,
        page: _currentPage,
        limit: _pageLimit,
      );
      _currentPage += 1;
      if (items.length < _pageLimit) {
        if (currentCategory != categories.last) {
          int nextPaginatedCategoryIndex =
              categories.indexOf(currentCategory) + 1;
          currentCategory = categories[nextPaginatedCategoryIndex];
          _currentPage = 0;
        }
      }
      _currentPaginatedCategory = currentCategory;
      previousItems.addAll(items);
      emit(
        state.copyWith(
          categories: state.categories,
          items: previousItems,
          status: MenuStatus.success,
        ),
      );
    } on Object {
      emit(
        state.copyWith(
          categories: state.categories,
          items: state.items,
          status: MenuStatus.error,
        ),
      );
      rethrow;
    } finally {
      emit(
        state.copyWith(
          categories: state.categories,
          items: state.items,
          status: MenuStatus.idle,
        ),
      );
    }
  }

  
    
  
}
