import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_coffee_shop/src/features/menu/data/menu_repository.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/coffee_title_model.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/coffee_card_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'menu_bloc_event.dart';
part 'menu_bloc_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc(this._repository) : super(const MenuState(status: MenuStatus.idle, items: [], categories: [])) {
    on<LoadCategoryEvent>(_loadCategory);
    on<LoadPageEvent>(_loadPage);
  }

  final MenuRepository _repository;

  CategoryModel? _currentPaginatedCategory;
  final int _currentPage = 0;

  final int _pageLimit = 25;

  Future<void> _loadCategory(event, emit) async {
    emit(MenuState(items: state.items, status: MenuStatus.loading));
    try {
      final categories = await _repository.getCategories();
      emit(
        MenuState(
          categories: categories,
          items: List.empty(),
          status: MenuStatus.success,
        ),
      );
    } on Object {
      emit(
        MenuState(
          categories: state.categories,
          items: state.items,
          status: MenuStatus.error,
        ),
      );
      rethrow;
    } finally {
      emit(
        MenuState(
          categories: state.categories,
          items: state.items,
          status: MenuStatus.idle,
        ),
      );
    }
  }

  Future<void> _loadPage(event, emit) async {
    _currentPaginatedCategory ??= state.categories?.first;
    if (_currentPaginatedCategory == null) return;

    emit(MenuState(items: state.items, status: MenuStatus.loading));
    try {
      final items = await _repository.getCards(
        category: _currentPaginatedCategory!,
        page: _currentPage,
        limit: _pageLimit,
      );
      if (items.length < _pageLimit) {}
      emit(
        MenuState(
          categories: state.categories,
          items: items,
          status: MenuStatus.success,
        ),
      );
    } on Object {
      emit(
        MenuState(
          categories: state.categories,
          items: state.items,
          status: MenuStatus.error,
        ),
      );
      rethrow;
    } finally {
      emit(
        MenuState(
          categories: state.categories,
          items: state.items,
          status: MenuStatus.idle,
        ),
      );
    }
  }
}
