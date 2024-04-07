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
    on<AddCoffee>((event, emit) async {
      Map<CoffeeCardModel, int> items = Map.from(state.cartItems);
      final count = items[event.coffee] ?? 0;
      if (count < 10) {
        items[event.coffee] = count + 1;
      }
      emit(state.copyWith(cartItems: items));
    });

    on<RemoveCoffee>((event, emit) async {
      Map<CoffeeCardModel, int> items = Map.from(state.cartItems);
      CoffeeCardModel newItem = event.coffee;
      if (items[newItem]! == 1) {
        items.remove(newItem);
      } else {
        items[newItem] = (items[newItem]! - 1);
      }
      if (items.isEmpty) {
        emit(state.copyWith(cartItems: <CoffeeCardModel, int>{},),);
      } else {
        emit(state.copyWith(cartItems: items),);
      }
    });

    on<PostOrder>((event, emit) async {
      Map<CoffeeCardModel, int> items = Map.from(state.cartItems);
      try {
        emit(state.copyWith(status: CartStatus.loading));
        await _repository.postOrder(items);
        emit(state.copyWith(status: CartStatus.success));
      } catch (_) {
        emit(state.copyWith(status: CartStatus.error, cartItems: items),);
        rethrow;
      }
    });

    on<DeleteOrder>((event, emit) async {
      emit(state.copyWith(cartItems: <CoffeeCardModel, int>{},),);
    });
  }

  final MenuRepository _repository;
}
