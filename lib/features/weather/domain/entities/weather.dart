import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final double temperature;
  final int weatherCode;
  final double windSpeed;
  final double humidity;
  final double visibility;
  final double uvIndex;
  final DateTime sunrise;
  final DateTime sunset;
  final String cityName;
  final String country;
  final List<HourlyWeather> hourlyForecast;
  final List<DailyWeather> dailyForecast;

  const Weather({
    required this.temperature,
    required this.weatherCode,
    required this.windSpeed,
    required this.humidity,
    required this.visibility,
    required this.uvIndex,
    required this.sunrise,
    required this.sunset,
    required this.cityName,
    required this.country,
    required this.hourlyForecast,
    required this.dailyForecast,
  });

  @override
  List<Object?> get props => [
        temperature,
        weatherCode,
        windSpeed,
        humidity,
        visibility,
        uvIndex,
        sunrise,
        sunset,
        cityName,
        country,
        hourlyForecast,
        dailyForecast,
      ];
}

class HourlyWeather extends Equatable {
  final DateTime time;
  final double temperature;
  final int weatherCode;
  final double windSpeed;
  final double humidity;
  final double precipitation;
  final double cloudCover;

  const HourlyWeather({
    required this.time,
    required this.temperature,
    required this.weatherCode,
    required this.windSpeed,
    required this.humidity,
    required this.precipitation,
    required this.cloudCover,
  });

  @override
  List<Object?> get props => [
        time,
        temperature,
        weatherCode,
        windSpeed,
        humidity,
        precipitation,
        cloudCover,
      ];
}

class DailyWeather extends Equatable {
  final DateTime date;
  final double maxTemperature;
  final double minTemperature;
  final int weatherCode;
  final double maxWindSpeed;
  final double uvIndex;
  final DateTime sunrise;
  final DateTime sunset;

  const DailyWeather({
    required this.date,
    required this.maxTemperature,
    required this.minTemperature,
    required this.weatherCode,
    required this.maxWindSpeed,
    required this.uvIndex,
    required this.sunrise,
    required this.sunset,
  });

  @override
  List<Object?> get props => [
        date,
        maxTemperature,
        minTemperature,
        weatherCode,
        maxWindSpeed,
        uvIndex,
        sunrise,
        sunset,
      ];
}
