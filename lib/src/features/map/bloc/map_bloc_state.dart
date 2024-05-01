part of 'map_bloc_bloc.dart';

enum MapStatus {
  idle,
  loading,
  error,
}

final class MapState extends Equatable {
  final List<LocationModel>? locations;
  final LocationModel? currentLocation;
  final MapStatus status;

  const MapState({
    this.status = MapStatus.idle,
    this.locations,
    this.currentLocation,
  });

  MapState copyWith({
    MapStatus? status,
    List<LocationModel>? locations,
    LocationModel? currentLocation,
  }) {
    return MapState(
      status: status ?? this.status,
      locations: locations ?? this.locations,
      currentLocation: currentLocation ?? this.currentLocation,
    );
  }

  @override
  String toString() {
    return '''MapStatus { status: $status, locations: ${locations?.length}, current location: ${currentLocation?.address}}''';
  }

  @override
  List<Object?> get props => [status, locations, currentLocation];
}
