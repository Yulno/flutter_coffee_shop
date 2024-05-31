import 'package:dio/dio.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/item_model.dart';

abstract interface class IOrderDataSource {
<<<<<<< HEAD
  Future<Map<String, dynamic>> postOrder({required Map<ItemModel, int> products});
=======
  Future<Map<String, dynamic>> postOrder(
      {required Map<ItemModel, int> products});
>>>>>>> feature/lab-4_map_screen
}

class NetworkOrdersDataSource implements IOrderDataSource {
  final Dio _dio;

  const NetworkOrdersDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<Map<String, dynamic>> postOrder({
    required Map<ItemModel, int> products,
  }) async {
<<<<<<< HEAD
    final positions =
        products.map((item, quantity) => MapEntry(item.id.toString(), quantity));
    final response = await _dio.post('/orders', data: {'positions': positions});
    if (response.statusCode == 201) {
      return response.data as Map<String, dynamic>;
    } else {
      throw const HttpException('/orders');
    }
=======
    final positions = products.map(
      (item, quantity) => MapEntry(item.id.toString(), quantity),
    );
    final response =
        await _dio.post('/orders', data: {'positions': positions, "token": ""});
    return response.data as Map<String, dynamic>;
>>>>>>> feature/lab-4_map_screen
  }
}
