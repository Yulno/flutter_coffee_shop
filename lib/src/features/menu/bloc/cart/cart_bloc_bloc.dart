import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_coffee_shop/src/features/menu/data/menu_repository.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/coffee_card_model.dart';
import 'package:meta/meta.dart';

part 'cart_bloc_event.dart';
part 'cart_bloc_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this._repository)
      : super(const CartState(cartItems: <CoffeeCardModel, int>{})) {
    on<AddCoffee>(_onAddCoffee);
    on<RemoveCoffee>(_onRemoveCoffee);
    on<PostOrder>(_onPostOrder);
    on<DeleteOrder>(_onDeleteOrder);
  }

  final MenuRepository _repository;

  Future<void> _onAddCoffee(event, emit) async {
    Map<CoffeeCardModel, int> items = Map.from(state.cartItems);
    final count = items[event.coffee] ?? 0;
    if (count < 10) {
      items[event.coffee] = count + 1;
    }
    emit(state.copyWith(status: CartStatus.filled, cartItems: items));
  }

  Future<void> _onRemoveCoffee(event, emit) async {
    Map<CoffeeCardModel, int> items = Map.from(state.cartItems);
    CoffeeCardModel newItem = event.coffee;
    if (items[newItem]! == 1) {
      items.remove(newItem);
    } else {
      items[newItem] = (items[newItem]! - 1);
    }
    if (items.isEmpty) {
      emit(state.copyWith(
          status: CartStatus.initial, cartItems: <CoffeeCardModel, int>{}));
    } else {
      emit(state.copyWith(status: CartStatus.filled, cartItems: items));
    }
  }

  Future<void> _onPostOrder(event, emit) async {
    Map<CoffeeCardModel, int> items = Map.from(state.cartItems);
    try {
      emit(state.copyWith(status: CartStatus.loading));
      await _repository.postOrder(items);
      emit(state.copyWith(status: CartStatus.success));
      emit(state.copyWith(status: CartStatus.initial));
    } catch (_) {
      emit(state.copyWith(status: CartStatus.failure, cartItems: items));
      rethrow;
    }
  }

  Future<void> _onDeleteOrder(event, emit) async {
    emit(state.copyWith(
        status: CartStatus.initial, cartItems: <CoffeeCardModel, int>{}));
  }
}