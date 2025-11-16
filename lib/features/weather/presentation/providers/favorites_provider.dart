import 'package:flutter/foundation.dart';
import '../../domain/usecases/manage_favorites.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/result.dart';

enum FavoritesStatus { initial, loading, success, error }

class FavoritesState {
  final FavoritesStatus status;
  final List<String> cities;
  final Failure? failure;

  const FavoritesState({
    required this.status,
    this.cities = const [],
    this.failure,
  });

  FavoritesState copyWith({
    FavoritesStatus? status,
    List<String>? cities,
    Failure? failure,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      cities: cities ?? this.cities,
      failure: failure,
    );
  }

  bool isFavorite(String cityName) {
    return cities.contains(cityName);
  }
}

class FavoritesProvider with ChangeNotifier {
  final ManageFavoritesUseCase manageFavoritesUseCase;

  FavoritesState _state = const FavoritesState(status: FavoritesStatus.initial);

  FavoritesProvider({required this.manageFavoritesUseCase}) {
    loadFavorites();
  }

  FavoritesState get state => _state;

  void _setState(FavoritesState newState) {
    _state = newState;
    notifyListeners();
  }

  /// Load favorite cities
  Future<void> loadFavorites() async {
    _setState(_state.copyWith(
      status: FavoritesStatus.loading,
      failure: null,
    ));

    final result = await manageFavoritesUseCase.getFavorites();

    result.fold(
      onError: (failure) {
        _setState(_state.copyWith(
          status: FavoritesStatus.error,
          failure: failure,
        ));
      },
      onSuccess: (cities) {
        _setState(_state.copyWith(
          status: FavoritesStatus.success,
          cities: cities,
          failure: null,
        ));
      },
    );
  }

  /// Add a city to favorites
  Future<bool> addFavorite(String cityName) async {
    final result = await manageFavoritesUseCase.addFavorite(cityName);

    return result.fold(
      onError: (failure) {
        _setState(_state.copyWith(failure: failure));
        return false;
      },
      onSuccess: (_) {
        final updatedCities = List<String>.from(_state.cities)..add(cityName);
        _setState(_state.copyWith(
          cities: updatedCities,
          failure: null,
        ));
        return true;
      },
    );
  }

  /// Remove a city from favorites
  Future<bool> removeFavorite(String cityName) async {
    final result = await manageFavoritesUseCase.removeFavorite(cityName);

    return result.fold(
      onError: (failure) {
        _setState(_state.copyWith(failure: failure));
        return false;
      },
      onSuccess: (_) {
        final updatedCities = List<String>.from(_state.cities)
          ..remove(cityName);
        _setState(_state.copyWith(
          cities: updatedCities,
          failure: null,
        ));
        return true;
      },
    );
  }

  /// Toggle favorite status for a city
  Future<bool> toggleFavorite(String cityName) async {
    if (_state.isFavorite(cityName)) {
      return await removeFavorite(cityName);
    } else {
      return await addFavorite(cityName);
    }
  }

  /// Check if a city is in favorites
  bool isFavorite(String cityName) {
    return _state.isFavorite(cityName);
  }

  /// Clear error state
  void clearError() {
    _setState(_state.copyWith(failure: null));
  }
}
