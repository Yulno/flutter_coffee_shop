import 'package:flutter_coffee_shop/src/features/menu/models/dto/menu_item_dto.dart';

abstract interface class IMenuDataSource {
  Future<List<MenuItemDto>> fetchMenuItems({required String categoryId, int page = 0, int limit = 25});
}

final class NetworkMenuDataSource implements IMenuDataSource {
  // Put dependency of network class such as dio or http, e.g.
  // final Dio _dio;

  const NetworkMenuDataSource(/*{required Dio dio}*/)/* : _dio = dio*/;

  @override
  Future<List<MenuItemDto>> fetchMenuItems({required String categoryId, int page = 0, int limit = 25}) {
    // TODO: implement fetchMenuItems
    throw UnimplementedError();
  }
}