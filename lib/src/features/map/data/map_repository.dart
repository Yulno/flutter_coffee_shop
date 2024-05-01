import 'dart:io';
import 'package:flutter_coffee_shop/src/features/map/data/data_sourses/locations_data_sourse.dart';
import 'package:flutter_coffee_shop/src/features/map/data/data_sourses/savable_locations_data_sourses.dart';
import 'package:flutter_coffee_shop/src/features/map/models/dto/location_dto.dart';
import 'package:flutter_coffee_shop/src/features/map/models/location_model.dart';
import 'package:flutter_coffee_shop/src/features/map/utils/location_mapper.dart';

abstract interface class ILocationsRepository {
  Future<List<LocationModel>> loadLocations();
}

final class LocationsRepository implements ILocationsRepository {
  final ILocationsDataSource _networkLocationsDataSource;
  final ISavableLocationsDataSource _dbLocationsDataSource;

  const LocationsRepository({
    required ILocationsDataSource networkLocationsDataSource,
    required ISavableLocationsDataSource dbLocationsDataSource,
  })  : _networkLocationsDataSource = networkLocationsDataSource,
        _dbLocationsDataSource = dbLocationsDataSource;

  @override
  Future<List<LocationModel>> loadLocations() async {
    List<LocationDto> dtos = <LocationDto>[];
    try {
      dtos = await _networkLocationsDataSource.fetchLocations();
      _dbLocationsDataSource.saveLocations(locations: dtos);
    } on SocketException {
      dtos = await _dbLocationsDataSource.fetchLocations();
    }
    return dtos.map((e) => e.toModel()).toList();
  }
}
