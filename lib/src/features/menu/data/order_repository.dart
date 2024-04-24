import 'dart:io';

import 'package:flutter_coffee_shop/src/features/menu/data/data_sources/order_data_source.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/item_model.dart';

abstract interface class IOrderRepository {
  Future<void> postOrder(Map<ItemModel, int> items);
}

final class OrderRepository implements IOrderRepository {
  final IOrderDataSource _networkOrderDataSource;

  OrderRepository({required IOrderDataSource networkOrderDataSource})
      : _networkOrderDataSource = networkOrderDataSource;

  @override
  Future<void> postOrder(Map<ItemModel, int> items) async {
    try {
      await _networkOrderDataSource.postOrder(items: items);
    } on SocketException {
      rethrow;
    }
  }
}