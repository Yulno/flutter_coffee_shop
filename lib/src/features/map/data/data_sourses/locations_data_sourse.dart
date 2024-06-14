import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_coffee_shop/src/features/map/models/dto/location_dto.dart';

abstract interface class ILocationsDataSource {
  Future<List<LocationDto>> fetchLocations();
}

final class NetworkLocationsDataSource implements ILocationsDataSource {
  final Dio _dio;

  const NetworkLocationsDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<List<LocationDto>> fetchLocations() async {
    try {
      final response = await _dio.get('/locations');
      final data = response.data['data'];
      if (data is! List) throw const FormatException();
      return (data)
          .map<LocationDto>(
            (i) => LocationDto.fromJSON(i as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw const SocketException('/locations');
      }
      rethrow;
    }
  }
}
