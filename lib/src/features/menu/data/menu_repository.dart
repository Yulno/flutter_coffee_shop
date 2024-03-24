import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_coffee_shop/src/common/network/api.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/coffee_title_model.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/coffee_card_model.dart';

abstract class MenuRepository {
  Future<List<CategoryModel>> getCategories();
  Future<CoffeeCardModel> getCoffeeCard(int id);
}

class MenuRepositoryImpl implements MenuRepository {
  MenuRepositoryImpl({required this.api, required this.dio});
  final Api api;
  final Dio dio;

  Future<GetData> _getData<GetData>({
    required Uri uri,
    required GetData Function(dynamic data) builder,
  }) async {
      final response = await dio.get(uri.toString());
      if (response.statusCode == 200 ) {
          final data = json.decode(response.data);
          return builder(data);}
      else {
          throw Exception('Failed to load');}
      }
  }

  Future<PostData> _postData<PostData>({
    required Uri uri,
    required PostData Function(dynamic data) builder,
  }) async {
      final response = await dio.post(uri.toString());
      if (response.statusCode == 201 ) {
          final data = json.decode(response.data);
          return builder(data);}
      else {
          throw Exception('Failed to load');}
      }
  }
  
  @override
  Future<List<CategoryModel>> getCategories() {
    // TODO: implement getCategories
    throw UnimplementedError();
  }
  
  @override
  Future<CoffeeCardModel> getCoffeeCard(int id) {
    // TODO: implement getCoffeeCard
    throw UnimplementedError();
  }
}
