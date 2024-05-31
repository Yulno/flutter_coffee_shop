import 'package:flutter_coffee_shop/src/common/data_base/database.dart';

class LocationDto {
  final String address;
  final double latitude;
  final double longitude;

  const LocationDto({
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory LocationDto.fromJSON(Map<String, dynamic> json) {
    return LocationDto(
      address: json['address'] as String,
      latitude: json['lat'] as double,
      longitude: json['lng'] as double,
    );
  }

  factory LocationDto.fromDB(Location location) {
    return LocationDto(
      address: location.address,
      latitude: location.latitude,
      longitude: location.longitude,
    );
  }
}