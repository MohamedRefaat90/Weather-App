import 'package:flutter/foundation.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/location.dart';
import '../../domain/repositories/location_repository.dart';
import '../../domain/usecases/search_location.dart';

class LocationProvider with ChangeNotifier {
  final SearchLocationUseCase searchLocationUseCase;
  final LocationRepository locationRepository;

  LocationState _state = const LocationState(status: LocationStatus.initial);

  LocationProvider({
    required this.searchLocationUseCase,
    required this.locationRepository,
  });

  LocationState get state => _state;

  /// Clear error state
  void clearError() {
    _setState(_state.copyWith(
      status: _state.location != null ? LocationStatus.success : LocationStatus.initial,
      failure: null,
    ));
  }

  /// Get current device location
  Future<void> getCurrentLocation() async {
    _setState(_state.copyWith(
      status: LocationStatus.loading,
      failure: null,
    ));

    final result = await locationRepository.getCurrentLocation();

    result.fold(
      onError: (failure) {
        _setState(_state.copyWith(
          status: LocationStatus.error,
          failure: failure,
        ));
      },
      onSuccess: (location) {
        _setState(_state.copyWith(
          status: LocationStatus.success,
          location: location,
          failure: null,
        ));
      },
    );
  }

  /// Check if location services are enabled
  Future<bool> isLocationServiceEnabled() async {
    return await locationRepository.isLocationServiceEnabled();
  }

  /// Request location permission
  Future<bool> requestLocationPermission() async {
    final result = await locationRepository.requestLocationPermission();
    return result.fold(
      onError: (_) => false,
      onSuccess: (granted) => granted,
    );
  }

  /// Search for a location by city name
  Future<void> searchLocation(String cityName) async {
    _setState(_state.copyWith(
      status: LocationStatus.loading,
      failure: null,
    ));

    final result = await searchLocationUseCase(cityName);

    result.fold(
      onError: (failure) {
        _setState(_state.copyWith(
          status: LocationStatus.error,
          failure: failure,
        ));
      },
      onSuccess: (location) {
        _setState(_state.copyWith(
          status: LocationStatus.success,
          location: location,
          failure: null,
        ));
      },
    );
  }

  void _setState(LocationState newState) {
    _state = newState;
    notifyListeners();
  }
}

class LocationState {
  final LocationStatus status;
  final Location? location;
  final Failure? failure;

  const LocationState({
    required this.status,
    this.location,
    this.failure,
  });

  LocationState copyWith({
    LocationStatus? status,
    Location? location,
    Failure? failure,
  }) {
    return LocationState(
      status: status ?? this.status,
      location: location ?? this.location,
      failure: failure,
    );
  }
}

enum LocationStatus { initial, loading, success, error }
