import 'package:flutter_coffee_shop/src/features/map/data/map_repository.dart';
import 'package:flutter_coffee_shop/src/features/map/models/location_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'map_bloc_event.dart';
part 'map_bloc_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc(this._locationsRepository)
      : super(const MapState(locations: [], currentLocation: null)) {
    on<LoadLocationsEvent>(_onLoadLocationsEvent);
    on<LoadMapEvent>(_onLoadMapEvent);
  }

  final ILocationsRepository _locationsRepository;

  Future<void> _onLoadLocationsEvent(LoadLocationsEvent event, emit) async {
    emit(state.copyWith(currentLocation: event.location));
  }

  Future<void> _onLoadMapEvent(LoadMapEvent event, emit) async {
    emit(
      state.copyWith(status: MapStatus.loading),
    );
    try {
      final List<LocationModel> locations =
          await _locationsRepository.loadLocations();
      emit(
        state.copyWith(
          locations: locations,
          status: MapStatus.idle,
          currentLocation: locations.isNotEmpty ? locations.first : null, 
        ),
      );
    } on Object {
      emit(state.copyWith(status: MapStatus.error));
      rethrow;
    } finally {
      emit(state.copyWith(status: MapStatus.idle));
    }
  }
}
