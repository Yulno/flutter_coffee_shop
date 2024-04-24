import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_coffee_shop/src/features/menu/data/order_repository.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/item_model.dart';
import 'package:meta/meta.dart';

part 'order_bloc_event.dart';
part 'order_bloc_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc(this._repository)
      : super(const OrderState(orderItems: <ItemModel, int>{})) {
    on<AddCoffee>((event, emit) async {
      Map<ItemModel, int> items = Map.from(state.orderItems);
      final count = event.count;
      if (count == 0) {
        items.remove(event.item);
      } else {
        items[event.item] = count;
      }
      emit(
        state.copyWith(
          orderItems: items,
          price: _priceCounter(items),
        ),
      );
    });

    on<PostOrder>((event, emit) async {
      emit(state.copyWith(status: OrderStatus.loading));
      Map<ItemModel, int> items = Map.from(state.orderItems);
      try {
        await _repository.postOrder(items);
        emit(
          state.copyWith(
            status: OrderStatus.success,
            orderItems: <ItemModel, int>{},
          ),
        );
      } catch (_) {
        emit(
          state.copyWith(
            status: OrderStatus.error,
          ),
        );
        rethrow;
      } finally {
        emit(
          state.copyWith(
            status: OrderStatus.idle,
          ),
        );
      }
    });

    on<DeleteOrder>((event, emit) async {
      emit(
        state.copyWith(
          orderItems: <ItemModel, int>{},
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

  final IOrderRepository _repository;
}
