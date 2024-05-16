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
      final response = await _dio.get(
        '/products',
        queryParameters: {
          'page': '$page',
          'limit': '$limit',
          'category': '$categoryId',
        },
      );
      if (response.statusCode == 200) {
        final data = response.data['data'];
        if (data is! List) throw const FormatException();
        return data
            .map((i) => ItemDto.fromJSON(i as Map<String, dynamic>))
            .toList();
      } else {
        throw HttpException('/products with categoryId = $categoryId');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw SocketException('/products with categoryId = $categoryId');
      }
      rethrow;
    }
  }

  @override
  Future<ItemDto> fetchItem({required int itemId}) async {
    try {
      final response = await _dio.get('products/$itemId');
      if (response.statusCode == 200) {
        final data = response.data['data'];
        return ItemDto.fromJSON(data as Map<String, dynamic>);
      } else {
        throw HttpException('/products/$itemId');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw SocketException('/products/$itemId');
      }
      rethrow;
    }
  }
}
