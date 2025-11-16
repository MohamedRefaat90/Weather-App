import '../../domain/entities/weather.dart';

class DailyWeatherModel extends DailyWeather {
  const DailyWeatherModel({
    required super.date,
    required super.maxTemperature,
    required super.minTemperature,
    required super.weatherCode,
    required super.maxWindSpeed,
    required super.uvIndex,
    required super.sunrise,
    required super.sunset,
  });

  factory DailyWeatherModel.fromJson(Map<String, dynamic> json) {
    return DailyWeatherModel(
      date: DateTime.parse(json['date'] as String),
      maxTemperature: (json['maxTemperature'] as num).toDouble(),
      minTemperature: (json['minTemperature'] as num).toDouble(),
      weatherCode: json['weatherCode'] as int,
      maxWindSpeed: (json['maxWindSpeed'] as num).toDouble(),
      uvIndex: (json['uvIndex'] as num).toDouble(),
      sunrise: DateTime.parse(json['sunrise'] as String),
      sunset: DateTime.parse(json['sunset'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'maxTemperature': maxTemperature,
      'minTemperature': minTemperature,
      'weatherCode': weatherCode,
      'maxWindSpeed': maxWindSpeed,
      'uvIndex': uvIndex,
      'sunrise': sunrise.toIso8601String(),
      'sunset': sunset.toIso8601String(),
    };
  }
}

class HourlyWeatherModel extends HourlyWeather {
  const HourlyWeatherModel({
    required super.time,
    required super.temperature,
    required super.weatherCode,
    required super.windSpeed,
    required super.humidity,
    required super.precipitation,
    required super.cloudCover,
  });

  factory HourlyWeatherModel.fromJson(Map<String, dynamic> json) {
    return HourlyWeatherModel(
      time: DateTime.parse(json['time'] as String),
      temperature: (json['temperature'] as num).toDouble(),
      weatherCode: json['weatherCode'] as int,
      windSpeed: (json['windSpeed'] as num).toDouble(),
      humidity: (json['humidity'] as num).toDouble(),
      precipitation: (json['precipitation'] as num).toDouble(),
      cloudCover: (json['cloudCover'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time.toIso8601String(),
      'temperature': temperature,
      'weatherCode': weatherCode,
      'windSpeed': windSpeed,
      'humidity': humidity,
      'precipitation': precipitation,
      'cloudCover': cloudCover,
    };
  }
}

class WeatherModel extends Weather {
  const WeatherModel({
    required super.temperature,
    required super.weatherCode,
    required super.windSpeed,
    required super.humidity,
    required super.visibility,
    required super.uvIndex,
    required super.sunrise,
    required super.sunset,
    required super.cityName,
    required super.country,
    required super.hourlyForecast,
    required super.dailyForecast,
  });

  factory WeatherModel.fromCacheJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature: (json['temperature'] as num).toDouble(),
      weatherCode: json['weatherCode'] as int,
      windSpeed: (json['windSpeed'] as num).toDouble(),
      humidity: (json['humidity'] as num).toDouble(),
      visibility: (json['visibility'] as num).toDouble(),
      uvIndex: (json['uvIndex'] as num).toDouble(),
      sunrise: DateTime.parse(json['sunrise'] as String),
      sunset: DateTime.parse(json['sunset'] as String),
      cityName: json['cityName'] as String,
      country: json['country'] as String,
      hourlyForecast: (json['hourlyForecast'] as List)
          .map((h) => HourlyWeatherModel.fromJson(h as Map<String, dynamic>))
          .toList(),
      dailyForecast: (json['dailyForecast'] as List)
          .map((d) => DailyWeatherModel.fromJson(d as Map<String, dynamic>))
          .toList(),
    );
  }

  factory WeatherModel.fromJson(
      Map<String, dynamic> json, String cityName, String country) {
    final current = json['current_weather'] as Map<String, dynamic>;
    final hourly = json['hourly'] as Map<String, dynamic>;
    final daily = json['daily'] as Map<String, dynamic>;

    // Parse hourly forecast (next 24 hours)
    final List<dynamic> hourlyTimes = hourly['time'] as List;
    final List<dynamic> hourlyTemps = hourly['temperature_2m'] as List;
    final List<dynamic> hourlyHumidity = hourly['relativehumidity_2m'] as List;
    final List<dynamic> hourlyWindSpeed = hourly['windspeed_10m'] as List;
    final List<dynamic> hourlyPrecipitation = hourly['precipitation'] as List;
    final List<dynamic> hourlyCloudCover = hourly['cloudcover'] as List;
    final List<dynamic> hourlyVisibility = hourly['visibility'] as List;

    final hourlyForecast = <HourlyWeatherModel>[];
    for (int i = 0; i < 24 && i < hourlyTimes.length; i++) {
      hourlyForecast.add(
        HourlyWeatherModel(
          time: DateTime.parse(hourlyTimes[i] as String),
          temperature: (hourlyTemps[i] as num).toDouble(),
          weatherCode: (current['weathercode'] as num).toInt(),
          windSpeed: (hourlyWindSpeed[i] as num).toDouble(),
          humidity: (hourlyHumidity[i] as num).toDouble(),
          precipitation: (hourlyPrecipitation[i] as num).toDouble(),
          cloudCover: (hourlyCloudCover[i] as num).toDouble(),
        ),
      );
    }

    // Parse daily forecast (next 7 days)
    final List<dynamic> dailyTimes = daily['time'] as List;
    final List<dynamic> dailyMaxTemps = daily['temperature_2m_max'] as List;
    final List<dynamic> dailyMinTemps = daily['temperature_2m_min'] as List;
    final List<dynamic> dailyWeatherCodes = daily['weathercode'] as List;
    final List<dynamic> dailyMaxWindSpeed = daily['windspeed_10m_max'] as List;
    final List<dynamic> dailyUvIndex = daily['uv_index_max'] as List;
    final List<dynamic> dailySunrise = daily['sunrise'] as List;
    final List<dynamic> dailySunset = daily['sunset'] as List;

    final dailyForecast = <DailyWeatherModel>[];
    for (int i = 0; i < dailyTimes.length; i++) {
      dailyForecast.add(
        DailyWeatherModel(
          date: DateTime.parse(dailyTimes[i] as String),
          maxTemperature: (dailyMaxTemps[i] as num).toDouble(),
          minTemperature: (dailyMinTemps[i] as num).toDouble(),
          weatherCode: (dailyWeatherCodes[i] as num).toInt(),
          maxWindSpeed: (dailyMaxWindSpeed[i] as num).toDouble(),
          uvIndex: (dailyUvIndex[i] as num).toDouble(),
          sunrise: DateTime.parse(dailySunrise[i] as String),
          sunset: DateTime.parse(dailySunset[i] as String),
        ),
      );
    }

    return WeatherModel(
      temperature: (current['temperature'] as num).toDouble(),
      weatherCode: (current['weathercode'] as num).toInt(),
      windSpeed: (current['windspeed'] as num).toDouble(),
      humidity: (hourlyHumidity[0] as num).toDouble(),
      visibility: (hourlyVisibility[0] as num).toDouble(),
      uvIndex: (dailyUvIndex[0] as num).toDouble(),
      sunrise: DateTime.parse(dailySunrise[0] as String),
      sunset: DateTime.parse(dailySunset[0] as String),
      cityName: cityName,
      country: country,
      hourlyForecast: hourlyForecast,
      dailyForecast: dailyForecast,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'weatherCode': weatherCode,
      'windSpeed': windSpeed,
      'humidity': humidity,
      'visibility': visibility,
      'uvIndex': uvIndex,
      'sunrise': sunrise.toIso8601String(),
      'sunset': sunset.toIso8601String(),
      'cityName': cityName,
      'country': country,
      'hourlyForecast': hourlyForecast
          .map((h) => (h as HourlyWeatherModel).toJson())
          .toList(),
      'dailyForecast':
          dailyForecast.map((d) => (d as DailyWeatherModel).toJson()).toList(),
    };
  }
}
