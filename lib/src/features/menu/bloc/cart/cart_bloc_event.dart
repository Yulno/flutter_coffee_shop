part of 'cart_bloc_bloc.dart';

@immutable
sealed class CartEvent {
  const CartEvent();
}

class AddCoffee extends CartEvent {
  final CoffeeCardModel coffee;

  const AddCoffee(this.coffee);

  @override
  String toString() => 'AddCoffee { id: ${coffee.id} }';
}

class PostOrder extends CartEvent {
  const PostOrder();

  @override
  String toString() => 'PostOrder';
}

class DeleteOrder extends CartEvent {
  const DeleteOrder();

  @override
  String toString() => 'DeleteOrder';
}
