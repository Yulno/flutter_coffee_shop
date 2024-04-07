part of 'cart_bloc_bloc.dart';

enum CartStatus { loading, success, error, idle }

final class CartState extends Equatable {
  final Map<CoffeeCardModel, int> cartItems;
  final CartStatus status;

  const CartState({
    this.status = CartStatus.idle,
    required this.cartItems,
  });

  CartState copyWith({
    CartStatus? status,
    Map<CoffeeCardModel, int>? cartItems,
  }) {
    return CartState(
      status: status ?? this.status,
      cartItems: cartItems ?? this.cartItems,
    );
  }

  @override
  String toString() {
    return '''CartStatus { status: $status, cartItems: ${cartItems.length} }''';
  }

  @override
  List<Object> get props => [status, cartItems];
}
