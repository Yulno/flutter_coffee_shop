import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/dto/item_dto.dart';

abstract interface class IItemsDataSource {
  Future<List<ItemDto>> fetchItems({
    required int categoryId,
    int page = 0,
    int limit = 25,
  });
  Future<ItemDto> fetchItem({required int itemId});
}

class NetworkItemsDataSource implements IItemsDataSource {
  final Dio _dio;

  const NetworkItemsDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<List<ItemDto>> fetchItems({
    required int categoryId,
    int page = 0,
    int limit = 25,
  }) async {
    try {
      final response = await _dio.get('/products', queryParameters: {
        'page': page,
        'limit': limit,
        'category': categoryId,
      },);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => ItemDto.fromJSON(item as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Failed to fetch items');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw SocketException('/products with categoryId = $categoryId');
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<ItemDto> fetchItem({required int itemId}) async {
    try {
      final response = await _dio.get('products/$itemId');
      if (response.statusCode == 200) {
        return ItemDto.fromJSON(response.data['data'] as Map<String, dynamic>);
      } else {
        throw Exception('Failed to fetch item');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw SocketException('/products/$itemId');
      } else {
        rethrow;
      }
    }
  }
}
