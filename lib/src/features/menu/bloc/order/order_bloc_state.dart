part of 'order_bloc_bloc.dart';

enum OrderStatus { loading, success, error, idle }

final class OrderState extends Equatable {
  final Map<ItemModel, int> orderItems;
  final OrderStatus status;
  final double price;

  const OrderState({
    this.status = OrderStatus.idle,
    required this.orderItems,
    this.price = 0,
  });

  OrderState copyWith({
    OrderStatus? status,
    Map<ItemModel, int>? orderItems,
    double? price,
  }) {
    return OrderState(
      status: status ?? this.status,
      orderItems: orderItems ?? this.orderItems,
      price: price ?? this.price,
    );
  }

  @override
  String toString() {
    return '''OrderStatus { status: $status, orderItems: ${orderItems.length} }''';
  }

  @override
  List<Object> get props => [status, orderItems, price,];
}
