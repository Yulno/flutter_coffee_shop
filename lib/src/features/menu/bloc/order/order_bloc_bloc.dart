import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_coffee_shop/src/features/menu/data/order_repository.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/item_model.dart';
import 'package:meta/meta.dart';

part 'order_bloc_event.dart';
part 'order_bloc_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc(this._orderRepository)
      : super(const OrderState(orderProducts: <ItemModel, int>{})) {
    on<AddCoffee>(_onAddCoffee);
    on<PostOrder>(_onPostOrder);
    on<DeleteOrder>(_onDeleteOrder);
  }
  final IOrderRepository _orderRepository;

  Future<void> _onAddCoffee(event, emit) async {
    Map<ItemModel, int> products = Map.from(state.orderProducts);
    final count = event.count;
    if (count == 0) {
      products.remove(event.item);
    } else {
      products[event.item as ItemModel] = count as int;
    }
    emit(
      state.copyWith(
        orderProducts: products,
        price: _priceCounter(products),
      ),
    );
  }

  Future<void> _onPostOrder(event, emit) async {
    emit(state.copyWith(status: OrderStatus.loading));
    Map<ItemModel, int> products = Map.from(state.orderProducts);
    try {
      await _orderRepository.postOrder(products);
      emit(
        state.copyWith(
          status: OrderStatus.success,
          orderProducts: <ItemModel, int>{},
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
  }

  Future<void> _onDeleteOrder(event, emit) async {
    emit(
      state.copyWith(
        orderProducts: <ItemModel, int>{},
      ),
    );
  }

  double _priceCounter(Map<ItemModel, int> items) {
    double prices = 0;
    for (var item in items.entries) {
      prices += item.key.price * item.value;
    }
    return prices;
  }
}
