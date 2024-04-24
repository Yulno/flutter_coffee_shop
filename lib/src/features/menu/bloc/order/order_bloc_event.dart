part of 'order_bloc_bloc.dart';

@immutable
sealed class OrderEvent extends Equatable {
  const OrderEvent();
}

class AddCoffee extends OrderEvent {
  final ItemModel item;
  final int count;

  const AddCoffee(this.item, this.count);

  @override
  String toString() => 'AddCoffee { id: ${item.id} }';
  
  @override
  List<Object?> get props => [item,];
}

class PostOrder extends OrderEvent {
  const PostOrder();

  @override
  String toString() => 'PostOrder';

  @override
  List<Object?> get props => [];
}

class DeleteOrder extends OrderEvent {
  const DeleteOrder();

  @override
  String toString() => 'DeleteOrder';

  @override
  List<Object?> get props => [];
}
