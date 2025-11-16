import '../../../../core/utils/result.dart';
import '../entities/location.dart';

abstract class LocationRepository {
  /// Get device's current location
  Future<Result<Location>> getCurrentLocation();

  /// Search for a location by city name
  Future<Result<Location>> searchLocation(String cityName);

  /// Get list of favorite cities
  Future<Result<List<String>>> getFavoriteCities();

  /// Add a city to favorites
  Future<Result<void>> addFavoriteCity(String cityName);

  /// Remove a city from favorites
  Future<Result<void>> removeFavoriteCity(String cityName);

  /// Check if location services are enabled
  Future<bool> isLocationServiceEnabled();

  /// Request location permission
  Future<Result<bool>> requestLocationPermission();
}
