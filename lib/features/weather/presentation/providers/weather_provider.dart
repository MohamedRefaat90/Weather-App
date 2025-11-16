import 'package:flutter/foundation.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/location.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../../domain/usecases/get_current_location_weather.dart';
import '../../domain/usecases/get_weather.dart';

class WeatherProvider with ChangeNotifier {
  final GetWeatherUseCase getWeatherUseCase;
  final GetCurrentLocationWeatherUseCase getCurrentLocationWeatherUseCase;
  final WeatherRepository weatherRepository;

  WeatherState _state = const WeatherState(status: WeatherStatus.initial);

  WeatherProvider({
    required this.getWeatherUseCase,
    required this.getCurrentLocationWeatherUseCase,
    required this.weatherRepository,
  });

  WeatherState get state => _state;

  /// Clear error state
  void clearError() {
    _setState(_state.copyWith(
      status: _state.weather != null ? WeatherStatus.success : WeatherStatus.initial,
      failure: null,
    ));
  }

  /// Get weather for current location
  Future<void> getCurrentLocationWeather() async {
    // Try to load cached data first
    await _loadCachedWeather();

    _setState(_state.copyWith(
      status: WeatherStatus.loading,
      failure: null,
    ));

    final result = await getCurrentLocationWeatherUseCase();

    result.fold(
      onError: (failure) {
        _setState(_state.copyWith(
          status: WeatherStatus.error,
          failure: failure,
        ));
      },
      onSuccess: (weather) {
        _setState(_state.copyWith(
          status: WeatherStatus.success,
          weather: weather,
          failure: null,
        ));
      },
    );
  }

  /// Get weather for specific location
  Future<void> getWeather(Location location) async {
    _setState(_state.copyWith(
      status: WeatherStatus.loading,
      failure: null,
    ));

    final result = await getWeatherUseCase(location);

    result.fold(
      onError: (failure) {
        _setState(_state.copyWith(
          status: WeatherStatus.error,
          failure: failure,
        ));
      },
      onSuccess: (weather) {
        _setState(_state.copyWith(
          status: WeatherStatus.success,
          weather: weather,
          failure: null,
        ));
      },
    );
  }

  /// Refresh weather data
  Future<void> refreshWeather() async {
    if (_state.weather == null) {
      await getCurrentLocationWeather();
      return;
    }

    _setState(_state.copyWith(isRefreshing: true));

    // Re-fetch current location weather
    await getCurrentLocationWeather();

    _setState(_state.copyWith(isRefreshing: false));
  }

  /// Retry after error
  Future<void> retry() async {
    if (_state.weather != null) {
      await refreshWeather();
    } else {
      await getCurrentLocationWeather();
    }
  }

  /// Load cached weather data
  Future<void> _loadCachedWeather() async {
    // Check if cache is valid
    final isCacheValid = await weatherRepository.isCacheValid();
    
    if (!isCacheValid) return;

    final result = await weatherRepository.getCachedWeather();

    if (result is Success<Weather>) {
      _setState(_state.copyWith(
        status: WeatherStatus.cached,
        weather: result.data,
      ));
    }
    // Ignore cache errors
  }

  void _setState(WeatherState newState) {
    _state = newState;
    notifyListeners();
  }
}

class WeatherState {
  final WeatherStatus status;
  final Weather? weather;
  final Failure? failure;
  final bool isRefreshing;

  const WeatherState({
    required this.status,
    this.weather,
    this.failure,
    this.isRefreshing = false,
  });

  bool get isDaytime {
    if (weather == null) return true;
    final now = DateTime.now();
    return now.isAfter(weather!.sunrise) && now.isBefore(weather!.sunset);
  }

  WeatherState copyWith({
    WeatherStatus? status,
    Weather? weather,
    Failure? failure,
    bool? isRefreshing,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
      failure: failure,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }
}

enum WeatherStatus { initial, loading, success, error, cached }
