import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/dto/category_dto.dart';

abstract interface class ICategoriesDataSource {
  Future<List<CategoryDto>> fetchCategories();
}

class NetworkCategoriesDataSource implements ICategoriesDataSource {
  final Dio _dio;

  const NetworkCategoriesDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<List<CategoryDto>> fetchCategories() async {
    try {
      final response = await _dio.get('/products/categories');
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((i) => CategoryDto.fromJSON(i as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Failed to fetch categories');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw const SocketException('/products/categories');
      } else {
        rethrow;
      }
    }
  }
}
