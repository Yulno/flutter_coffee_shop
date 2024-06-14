part of 'map_bloc_bloc.dart';

@immutable
sealed class MapEvent extends Equatable {
  const MapEvent();
}

class LoadLocationsEvent extends MapEvent {
  final LocationModel location;
  const LoadLocationsEvent(
    this.location,
  );

  @override
  String toString() => 'LoadLocationsEvent { id: ${location.address} }';

  @override
  List<Object> get props => [
        location,
      ];
}

class LoadMapEvent extends MapEvent {
  const LoadMapEvent();

  @override
  String toString() => 'LoadMapEvent';

  @override
  List<Object> get props => [];
}
