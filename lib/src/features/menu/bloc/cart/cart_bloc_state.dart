part of 'cart_bloc_bloc.dart';

enum CartStatus { loading, success, error, idle }

final class CartState extends Equatable {
  final Map<ItemModel, int> cartItems;
  final CartStatus status;
  final double price;

  const CartState({
    this.status = CartStatus.idle,
    required this.cartItems,
    this.price = 0,
  });

  CartState copyWith({
    CartStatus? status,
    Map<ItemModel, int>? cartItems,
    double? price,
  }) {
    return CartState(
      status: status ?? this.status,
      cartItems: cartItems ?? this.cartItems,
      price: price ?? this.price,
    );
  }

  @override
  String toString() {
    return '''CartStatus { status: $status, cartItems: ${cartItems.length} }''';
  }

  @override
  List<Object> get props => [status, cartItems, price,];
}
