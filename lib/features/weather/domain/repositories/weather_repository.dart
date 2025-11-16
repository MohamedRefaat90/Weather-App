import '../../../../core/utils/result.dart';
import '../entities/location.dart';
import '../entities/weather.dart';

abstract class WeatherRepository {
  /// Get weather data for a specific location
  Future<Result<Weather>> getWeather(Location location);

  /// Get weather data for current device location
  Future<Result<Weather>> getWeatherByCurrentLocation();

  /// Get cached weather data
  Future<Result<Weather>> getCachedWeather();

  /// Cache weather data
  Future<Result<void>> cacheWeather(Weather weather);

  /// Check if cache is valid (not expired)
  Future<bool> isCacheValid();
}
