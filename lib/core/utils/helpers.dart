import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeHelper {
  /// Format DateTime to "Monday, 12 Nov"
  static String formatDate(DateTime dateTime) {
    return DateFormat('EEEE, d MMM').format(dateTime);
  }

  /// Format day of week "Monday"
  static String formatDayOfWeek(DateTime dateTime) {
    return DateFormat('EEEE').format(dateTime);
  }

  /// Format DateTime to "Mon"
  static String formatDayShort(DateTime dateTime) {
    return DateFormat('EEE').format(dateTime);
  }

  /// Format DateTime to "12 PM"
  static String formatHour(DateTime dateTime) {
    return DateFormat('h a').format(dateTime);
  }

  /// Format short day "Mon"
  static String formatShortDay(DateTime dateTime) {
    return DateFormat('EEE').format(dateTime);
  }

  /// Format DateTime to "12:30 PM"
  static String formatTime(DateTime dateTime) {
    return DateFormat('h:mm a').format(dateTime);
  }

  /// Get day name from date string "2024-11-16"
  static String getDayName(String dateString) {
    final date = DateTime.parse(dateString);
    return DateFormat('EEEE').format(date);
  }

  /// Get short day name from date string "2024-11-16"
  static String getDayNameShort(String dateString) {
    final date = DateTime.parse(dateString);
    return DateFormat('EEE').format(date);
  }

  /// Check if given hour is current hour
  static bool isCurrentHour(String hourString) {
    final hour = DateTime.parse(hourString);
    final now = DateTime.now();
    return hour.hour == now.hour && hour.day == now.day;
  }

  /// Check if it's daytime based on sunrise and sunset
  static bool isDaytime(DateTime now, DateTime sunrise, DateTime sunset) {
    return now.isAfter(sunrise) && now.isBefore(sunset);
  }
}

class TemperatureHelper {
  /// Convert Celsius to Fahrenheit
  static double celsiusToFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }

  /// Convert Fahrenheit to Celsius
  static double fahrenheitToCelsius(double fahrenheit) {
    return (fahrenheit - 32) * 5 / 9;
  }

  /// Format temperature with unit
  static String formatTemperature(double temperature, {bool isCelsius = true}) {
    return '${temperature.round()}°${isCelsius ? 'C' : 'F'}';
  }
}

class WeatherHelper {
  /// Get gradient colors based on weather code
  /// Weather Codes Reference:
  /// 0: Clear sky
  /// 1-2: Mainly clear, partly cloudy
  /// 3: Overcast
  /// 45-48: Fog
  /// 51-57: Drizzle
  /// 61-67: Rain
  /// 71-77: Snow fall
  /// 80-82: Rain showers
  /// 85-86: Snow showers
  /// 95-99: Thunderstorm
  static List<Color> getMainWeatherCardGradient(
      int weatherCode, bool isDaytime) {
    if (weatherCode == 0) {
      // Code 0: Clear sky
      return isDaytime
          ? const [Color(0xFFFFA726), Color(0xFFEC407A)] // Sunny
          : const [Color(0xFF455A64), Color(0xFF3F51B5)]; // Night
    } else if (weatherCode == 1 || weatherCode == 2) {
      // Code 1-2: Mainly clear, partly cloudy
      return const [
        Color(0xFF7E57C2),
        Color(0xFF5E35B1)
      ]; // Partly Cloudy - Purple
    } else if (weatherCode == 3) {
      // Code 3: Overcast
      return const [
        Color(0xFF607D8B),
        Color(0xFF78909C)
      ]; // Cloudy/Overcast - Grey/Blue-grey
    } else if (weatherCode >= 61 && weatherCode <= 67 ||
        weatherCode >= 80 && weatherCode <= 82) {
      // Code 61-67: Rain, Code 80-82: Rain showers
      return const [Color(0xFF42A5F5), Color(0xFF1E88E5)]; // Rainy
    } else if (weatherCode >= 71 && weatherCode <= 77 ||
        weatherCode >= 85 && weatherCode <= 86) {
      // Code 71-77: Snow fall, Code 85-86: Snow showers
      return const [Color(0xFF90CAF9), Color(0xFFE3F2FD)]; // Snowy
    } else if (weatherCode >= 95 && weatherCode <= 99) {
      // Code 95-99: Thunderstorm
      return isDaytime
          ? const [
              Color(0xFF4A148C),
              Color(0xFF6A1B9A)
            ] // Thunderstorm Day - Deep purple
          : const [
              Color(0xFF1A237E),
              Color(0xFF311B92)
            ]; // Thunderstorm Night - Dark blue-purple
    }
    return isDaytime
        ? const [Color(0xFFFFA726), Color(0xFFEC407A)]
        : const [Color(0xFF455A64), Color(0xFF3F51B5)];
  }

  /// Get Lottie animation path based on weather code
  /// See weather code reference in getMainWeatherCardGradient
  static String getWeatherAnimation(int weatherCode, bool isDaytime) {
    if (weatherCode == 0) {
      // Code 0: Clear sky
      return isDaytime ? 'assets/icons/Sunny.json' : 'assets/icons/night.json';
    } else if (weatherCode >= 1 && weatherCode <= 3) {
      // Code 1-3: Partly cloudy to overcast
      return isDaytime
          ? 'assets/icons/partly-cloudy.json'
          : 'assets/icons/cloudynight.json';
    } else if (weatherCode == 45 || weatherCode == 48) {
      // Code 45-48: Fog
      return 'assets/icons/Foggy.json';
    } else if (weatherCode >= 51 && weatherCode <= 57) {
      // Code 51-57: Drizzle
      return 'assets/icons/Drizzel.json';
    } else if (weatherCode >= 61 && weatherCode <= 67 ||
        weatherCode >= 80 && weatherCode <= 82) {
      // Code 61-67: Rain, Code 80-82: Rain showers
      return 'assets/icons/Rain.json';
    } else if (weatherCode >= 71 && weatherCode <= 77 ||
        weatherCode >= 85 && weatherCode <= 86) {
      // Code 71-77: Snow fall, Code 85-86: Snow showers
      return 'assets/icons/Snow.json';
    } else if (weatherCode >= 95 && weatherCode <= 99) {
      // Code 95-99: Thunderstorm
      return 'assets/icons/thunderstorm.json';
    }
    return 'assets/icons/Sunny.json';
  }

  /// Get weather icon based on weather code
  /// See weather code reference in getMainWeatherCardGradient
  static IconData getWeatherIcon(int weatherCode) {
    if (weatherCode == 0) {
      // Code 0: Clear sky
      return Icons.wb_sunny;
    } else if (weatherCode >= 1 && weatherCode <= 3) {
      // Code 1-3: Partly cloudy to overcast
      return Icons.wb_cloudy;
    } else if (weatherCode == 45 || weatherCode == 48) {
      // Code 45-48: Fog
      return Icons.foggy;
    } else if (weatherCode >= 51 && weatherCode <= 67) {
      // Code 51-67: Drizzle to rain
      return Icons.water_drop;
    } else if (weatherCode >= 71 && weatherCode <= 86) {
      // Code 71-86: Snow
      return Icons.ac_unit;
    } else if (weatherCode >= 95 && weatherCode <= 99) {
      // Code 95-99: Thunderstorm
      return Icons.thunderstorm;
    }
    return Icons.wb_sunny;
  }
}
