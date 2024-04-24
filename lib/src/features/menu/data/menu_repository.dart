import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_coffee_shop/src/common/network/api.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/category_model.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/item_model.dart';

abstract class MenuRepository {
  Future<List<CategoryModel>> getCategory({int? page, int? limit});
  Future<ItemModel> getItem(int id);
  Future<void> postOrder(Map<ItemModel, int> items);
  Future<List<ItemModel>> getItems(
      {int? page, int? limit, CategoryModel? category,});
}

class MenuRepositoryImpl implements MenuRepository {
  MenuRepositoryImpl({required this.api, required this.dio});
  final Api api;
  final Dio dio;

  Future<GetData> _getData<GetData>({
    required Uri uri,
    required GetData Function(dynamic data) builder,
  }) async {
    try {
      final response = await dio.get(uri.toString());
      if (response.statusCode == 200) {
        final data = response.data['data'];
        return builder(data);
      } else {
        throw Exception('Failed to load');
      }
    } on SocketException catch (_) {
      throw Exception('No internet connection');
    }
  }

  @override
  Future<bool> postOrder(Map<ItemModel, int> items) => _postData(
        uri: api.order(),
        sendingData: {
          "positions": items.map(
            (key, value) => MapEntry(key.id.toString(), value),
          ),
          "token": "<FCM Registration Token>",
        },
      );

  Future<bool> _postData({
    required Uri uri,
    required Object sendingData,
  }) async {
    try {
      final request = sendingData;
      final response = await dio.post(
        uri.toString(),
        data: json.encode(request),
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception('Failed to load');
      }
    } on SocketException catch (_) {
      throw Exception('No internet connection');
    }
  }

  @override
  Future<List<CategoryModel>> getCategory({int? page, int? limit}) =>
      _getData(
        uri: api.categories(page: page, limit: limit),
        builder: (data) => (data as List)
            .map<CategoryModel>(
                (i) => CategoryModel.fromJSON(i as Map<String, dynamic>),)
            .toList(),
      );

  @override
  Future<List<ItemModel>> getItems(
          {int? page, int? limit, CategoryModel? category,}) =>
      _getData(
        uri: api.items(page: page, limit: limit, category: category?.id),
        builder: (data) => (data as List)
            .map<ItemModel>(
                (i) => ItemModel.fromJSON(i as Map<String, dynamic>),)
            .toList(),
      );

  @override
  Future<ItemModel> getItem(int id) => _getData(
        uri: api.item(id),
        builder: (data) =>
            ItemModel.fromJSON(data as Map<String, dynamic>),
      );
}
