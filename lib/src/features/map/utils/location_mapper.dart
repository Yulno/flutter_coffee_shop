import 'package:flutter_coffee_shop/src/features/map/models/dto/location_dto.dart';
import 'package:flutter_coffee_shop/src/features/map/models/location_model.dart';

extension LocationMapper on LocationDto {
  LocationModel toModel() =>
      LocationModel(address: address, latitude: latitude, longitude: longitude);
}
