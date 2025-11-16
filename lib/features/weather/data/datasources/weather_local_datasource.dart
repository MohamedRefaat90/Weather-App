import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/weather_model.dart';

abstract class WeatherLocalDataSource {
  /// Cache weather data
  Future<void> cacheWeather(WeatherModel weather);

  /// Clear cached weather data
  Future<void> clearCache();

  /// Get cached weather data
  Future<WeatherModel> getCachedWeather();

  /// Get last update timestamp
  Future<DateTime?> getLastUpdateTime();

  /// Check if cache is still valid
  Future<bool> isCacheValid();
}

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final SharedPreferences sharedPreferences;

  WeatherLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheWeather(WeatherModel weather) async {
    try {
      final jsonString = jsonEncode(weather.toJson());
      await sharedPreferences.setString(
          AppConstants.weatherCacheKey, jsonString);

      // Save current timestamp
      await sharedPreferences.setInt(
        AppConstants.lastUpdateKey,
        DateTime.now().millisecondsSinceEpoch,
      );
    } catch (e) {
      throw CacheException('Failed to cache weather: $e');
    }
  }

  @override
  Future<void> clearCache() async {
    await sharedPreferences.remove(AppConstants.weatherCacheKey);
    await sharedPreferences.remove(AppConstants.lastUpdateKey);
  }

  @override
  Future<WeatherModel> getCachedWeather() async {
    try {
      final jsonString =
          sharedPreferences.getString(AppConstants.weatherCacheKey);

      if (jsonString == null) {
        throw const CacheException('No cached weather data found');
      }

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return WeatherModel.fromCacheJson(json);
    } catch (e) {
      throw CacheException('Failed to read cache: $e');
    }
  }

  @override
  Future<DateTime?> getLastUpdateTime() async {
    final timestamp = sharedPreferences.getInt(AppConstants.lastUpdateKey);
    if (timestamp == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  @override
  Future<bool> isCacheValid() async {
    final lastUpdate = await getLastUpdateTime();
    if (lastUpdate == null) return false;

    final now = DateTime.now();
    final difference = now.difference(lastUpdate);

    return difference < AppConstants.cacheExpiration;
  }
}
