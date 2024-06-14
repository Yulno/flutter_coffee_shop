import 'package:dio/dio.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/item_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

abstract interface class IOrderDataSource {
  Future<Map<String, dynamic>> postOrder(
      {required Map<ItemModel, int> products,});
}

class NetworkOrdersDataSource implements IOrderDataSource {
  final Dio _dio;

  const NetworkOrdersDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<Map<String, dynamic>> postOrder({
    required Map<ItemModel, int> products,
  }) async {
    final positions = products.map(
      (item, quantity) => MapEntry(item.id.toString(), quantity),
    );
    final fcmToken = await FirebaseMessaging.instance.getToken();
    final response = await _dio.post('/orders', data: {'positions': positions, "token": fcmToken});
    return response.data as Map<String, dynamic>;
  }
}
