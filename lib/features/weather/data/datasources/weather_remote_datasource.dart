import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  /// Fetch weather data from API
  Future<WeatherModel> getWeather({
    required double latitude,
    required double longitude,
    required String cityName,
    required String country,
  });
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getWeather({
    required double latitude,
    required double longitude,
    required String cityName,
    required String country,
  }) async {
    try {
      final uri = Uri.parse(
        '${AppConstants.baseUrl}/${AppConstants.apiVersion}/forecast'
        '?latitude=$latitude'
        '&longitude=$longitude'
        '&hourly=temperature_2m,relativehumidity_2m,visibility,windspeed_10m,precipitation,rain,showers,snowfall,cloudcover'
        '&daily=sunrise,sunset,weathercode,temperature_2m_max,temperature_2m_min,uv_index_max,uv_index_clear_sky_max,windspeed_10m_max'
        '&current_weather=true'
        '&timezone=auto',
      );

      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return WeatherModel.fromJson(json, cityName, country);
      } else {
        throw ServerException(
            'Failed to fetch weather data: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException('Network error: $e');
    }
  }
}
