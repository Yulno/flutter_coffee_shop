import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_coffee_shop/src/common/network/api.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/coffee_title_model.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/coffee_card_model.dart';

abstract class MenuRepository {
  Future<List<CategoryModel>> getCategories({int? page, int? limit});
  Future<CoffeeCardModel> getCoffeeCard(int id);
  Future<void> postOrder(Map<CoffeeCardModel, int> items);
  Future<List<CoffeeCardModel>> getCards(
      {int? page, int? limit, CategoryModel? category});
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
  Future<bool> postOrder(Map<CoffeeCardModel, int> items) => _postData(
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
  Future<List<CategoryModel>> getCategories({int? page, int? limit}) =>
      _getData(
        uri: api.categories(page: page, limit: limit),
        builder: (data) => (data as List)
            .map<CategoryModel>(
                (i) => CategoryModel.fromJSON(i as Map<String, dynamic>))
            .toList(),
      );

  @override
  Future<List<CoffeeCardModel>> getCards(
          {int? page, int? limit, CategoryModel? category}) =>
      _getData(
        uri: api.cards(page: page, limit: limit, category: category?.id),
        builder: (data) => (data as List)
            .map<CoffeeCardModel>(
                (i) => CoffeeCardModel.fromJSON(i as Map<String, dynamic>))
            .toList(),
      );

  @override
  Future<CoffeeCardModel> getCoffeeCard(int id) => _getData(
        uri: api.card(id),
        builder: (data) =>
            CoffeeCardModel.fromJSON(data as Map<String, dynamic>),
      );
}
