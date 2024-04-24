import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_coffee_shop/src/features/menu/data/menu_repository.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/item_model.dart';
import 'package:meta/meta.dart';

part 'cart_bloc_event.dart';
part 'cart_bloc_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this._repository)
      : super(const CartState(cartItems: <ItemModel, int>{})) {
    on<AddCoffee>((event, emit) async {
      Map<ItemModel, int> items = Map.from(state.cartItems);
      final count = event.count;
      items[event.item] = count;
      emit(
        state.copyWith(
          cartItems: items,
          price: _priceCounter(items),
        ),
      );
    });

    on<PostOrder>((event, emit) async {
      emit(state.copyWith(status: CartStatus.loading));
      Map<ItemModel, int> items = Map.from(state.cartItems);
      try {
        await _repository.postOrder(items);
        emit(
          state.copyWith(
            status: CartStatus.success,
            cartItems: <ItemModel, int>{},
          ),
        );
      } catch (_) {
        emit(
          state.copyWith(
            status: CartStatus.error,
          ),
        );
        rethrow;
      } finally {
        emit(
          state.copyWith(
            status: CartStatus.idle,
          ),
        );
      }
    });

    on<DeleteOrder>((event, emit) async {
      emit(
        state.copyWith(
          cartItems: <ItemModel, int>{},
        ),
      );
    });
  }

  double _priceCounter(Map<ItemModel, int> items) {
    double prices = 0;
    for (var item in items.entries) {
      prices += item.key.price * item.value;
    }
    return prices;
  }

  final MenuRepository _repository;
}
