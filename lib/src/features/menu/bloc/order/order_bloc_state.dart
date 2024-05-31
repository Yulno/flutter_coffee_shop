part of 'order_bloc_bloc.dart';

enum OrderStatus { loading, success, error, idle }

final class OrderState extends Equatable {
  final Map<ItemModel, int> orderProducts;
  final OrderStatus status;
  final double price;

  const OrderState({
    this.status = OrderStatus.idle,
    required this.orderProducts,
    this.price = 0,
  });

  OrderState copyWith({
    OrderStatus? status,
    Map<ItemModel, int>? orderProducts,
    double? price,
  }) {
    return OrderState(
      status: status ?? this.status,
      orderProducts: orderProducts ?? this.orderProducts,
      price: price ?? this.price,
    );
  }

  @override
  String toString() {
    return '''OrderStatus { status: $status, orderProducts: ${orderProducts.length}, fullcosts: $price}''';
  }

  @override
  List<Object> get props => [status, orderProducts, price,];
}
