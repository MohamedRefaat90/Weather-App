class AppConstants {
  // API Constants
  static const String baseUrl = 'https://api.open-meteo.com';
  static const String apiVersion = 'v1';

  // Cache Constants
  static const String weatherCacheKey = 'weather_cache';
  static const String lastUpdateKey = 'last_update';
  static const String favoriteCitiesKey = 'favorite_cities';
  static const String themeKey = 'theme_mode';
  static const String temperatureUnitKey = 'temperature_unit';

  // Cache Expiration
  static const Duration cacheExpiration = Duration(hours: 6);

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);

  // UI Constants
  static const double borderRadius = 20.0;
  static const double cardElevation = 0.0;
  static const double padding = 16.0;
  static const double spacing = 8.0;

  // Weather Code Ranges
  static const List<int> clearCodes = [0];
  static const List<int> cloudyCodes = [1, 2, 3];
  static const List<int> foggyCodes = [45, 48];
  static const List<int> drizzleCodes = [51, 53, 55, 56, 57];
  static const List<int> rainCodes = [61, 63, 65, 66, 67, 80, 81, 82];
  static const List<int> snowCodes = [71, 73, 75, 77, 85, 86];
  static const List<int> thunderstormCodes = [95, 96, 99];

  // Default Values
  static const String defaultCity = 'London';
  static const double defaultLatitude = 51.5074;
  static const double defaultLongitude = -0.1278;
}

class WeatherCodeDescriptions {
  static const Map<int, String> descriptions = {
    0: 'Clear Sky',
    1: 'Mainly Clear',
    2: 'Partly Cloudy',
    3: 'Overcast',
    45: 'Foggy',
    48: 'Depositing Rime Fog',
    51: 'Light Drizzle',
    53: 'Moderate Drizzle',
    55: 'Dense Drizzle',
    56: 'Light Freezing Drizzle',
    57: 'Dense Freezing Drizzle',
    61: 'Slight Rain',
    63: 'Moderate Rain',
    65: 'Heavy Rain',
    66: 'Light Freezing Rain',
    67: 'Heavy Freezing Rain',
    71: 'Slight Snow',
    73: 'Moderate Snow',
    75: 'Heavy Snow',
    77: 'Snow Grains',
    80: 'Slight Rain Showers',
    81: 'Moderate Rain Showers',
    82: 'Violent Rain Showers',
    85: 'Slight Snow Showers',
    86: 'Heavy Snow Showers',
    95: 'Thunderstorm',
    96: 'Thunderstorm with Slight Hail',
    99: 'Thunderstorm with Heavy Hail',
  };

  static String getDescription(int code) {
    return descriptions[code] ?? 'Unknown';
  }
}
