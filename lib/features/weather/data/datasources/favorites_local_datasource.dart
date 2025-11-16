import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/exceptions.dart';

abstract class FavoritesLocalDataSource {
  /// Get list of favorite cities
  Future<List<String>> getFavoriteCities();

  /// Add a city to favorites
  Future<void> addFavoriteCity(String cityName);

  /// Remove a city from favorites
  Future<void> removeFavoriteCity(String cityName);

  /// Check if a city is in favorites
  Future<bool> isFavorite(String cityName);
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  final SharedPreferences sharedPreferences;

  FavoritesLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<String>> getFavoriteCities() async {
    try {
      final jsonString =
          sharedPreferences.getString(AppConstants.favoriteCitiesKey);

      if (jsonString == null) {
        return [];
      }

      final List<dynamic> decoded = jsonDecode(jsonString) as List;
      return decoded.map((e) => e.toString()).toList();
    } catch (e) {
      throw CacheException('Failed to read favorites: $e');
    }
  }

  @override
  Future<void> addFavoriteCity(String cityName) async {
    try {
      final favorites = await getFavoriteCities();

      if (!favorites.contains(cityName)) {
        favorites.add(cityName);
        final jsonString = jsonEncode(favorites);
        await sharedPreferences.setString(
          AppConstants.favoriteCitiesKey,
          jsonString,
        );
      }
    } catch (e) {
      throw CacheException('Failed to add favorite: $e');
    }
  }

  @override
  Future<void> removeFavoriteCity(String cityName) async {
    try {
      final favorites = await getFavoriteCities();
      favorites.remove(cityName);

      final jsonString = jsonEncode(favorites);
      await sharedPreferences.setString(
        AppConstants.favoriteCitiesKey,
        jsonString,
      );
    } catch (e) {
      throw CacheException('Failed to remove favorite: $e');
    }
  }

  @override
  Future<bool> isFavorite(String cityName) async {
    final favorites = await getFavoriteCities();
    return favorites.contains(cityName);
  }
}
