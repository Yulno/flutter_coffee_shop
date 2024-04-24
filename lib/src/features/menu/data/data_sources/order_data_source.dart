import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/item_model.dart';

abstract interface class IOrderDataSource {
  Future<Map<String, dynamic>> postOrder({required Map<ItemModel, int> items});
}

class NetworkOrdersDataSource implements IOrderDataSource {
  final Dio _dio;

  const NetworkOrdersDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<Map<String, dynamic>> postOrder({required Map<ItemModel, int> items}) async {
    final positions = items.map((item, quantity) => MapEntry(item.id.toString(), quantity));
    final response = await _dio.post('/orders', data: {'positions': positions});
    if (response.statusCode == 201) {
      return response.data as Map<String, dynamic>;
    } else {
      throw const HttpException('/orders');
    }
  }
}
