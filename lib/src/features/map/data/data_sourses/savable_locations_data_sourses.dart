import 'package:flutter_coffee_shop/src/common/data_base/database.dart';
import 'package:flutter_coffee_shop/src/features/map/data/data_sourses/locations_data_sourse.dart';
import 'package:flutter_coffee_shop/src/features/map/models/dto/location_dto.dart';

abstract interface class ISavableLocationsDataSource
    implements ILocationsDataSource {
  Future<void> saveLocations({required List<LocationDto> locations});
}

final class DbLocationsDataSource implements ISavableLocationsDataSource {
  final AppDatabase _db;

  const DbLocationsDataSource({required AppDatabase db}) : _db = db;

  @override
  Future<List<LocationDto>> fetchLocations() async {
    final result = await (_db.select(_db.locations)).get();
    return List<LocationDto>.of(
      result.map((location) => LocationDto.fromDB(location)),
    );
  }

  @override
  Future<void> saveLocations({required List<LocationDto> locations}) async {
    for (LocationDto location in locations) {
      _db.into(_db.locations).insertOnConflictUpdate(
            LocationsCompanion.insert(
              address: location.address,
              latitude: location.latitude,
              longitude: location.longitude,
            ),
          );
    }
  }
}
