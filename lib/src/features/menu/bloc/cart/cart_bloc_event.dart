part of 'cart_bloc_bloc.dart';

@immutable
sealed class CartEvent extends Equatable {
  const CartEvent();
}

class AddCoffee extends CartEvent {
  final CoffeeCardModel card;
  final int count;

  const AddCoffee(this.card, this.count);

  @override
  String toString() => 'AddCoffee { id: ${card.id} }';
  
  @override
  List<Object?> get props => [card,];
}

class PostOrder extends CartEvent {
  const PostOrder();

  @override
  String toString() => 'PostOrder';

  @override
  List<Object?> get props => [];
}

class DeleteOrder extends CartEvent {
  const DeleteOrder();

  @override
  String toString() => 'DeleteOrder';

  @override
  List<Object?> get props => [];
}
