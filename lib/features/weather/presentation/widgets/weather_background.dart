import 'package:flutter/material.dart';

/// Widget that provides weather-based gradient background
class WeatherBackground extends StatelessWidget {
  final int weatherCode;
  final bool isDaytime;
  final Widget child;

  const WeatherBackground({
    super.key,
    required this.weatherCode,
    required this.isDaytime,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: _getWeatherGradient(weatherCode, isDaytime),
        ),
      ),
      child: child,
    );
  }

  List<Color> _getWeatherGradient(int weatherCode, bool isDaytime) {
    if (!isDaytime) {
      return const [
        Color(0xFF0F2027),
        Color(0xFF203A43),
        Color(0xFF2C5364),
      ];
    }

    // Clear/Sunny
    if (weatherCode >= 0 && weatherCode <= 1) {
      return const [
        Color(0xFF56CCF2),
        Color(0xFF2F80ED),
      ];
    }

    // Partly Cloudy
    if (weatherCode == 2) {
      return const [
        Color(0xFF89ABE3),
        Color(0xFFEA738D),
      ];
    }

    // Cloudy/Overcast
    if (weatherCode == 3) {
      return const [
        Color(0xFF757F9A),
        Color.fromARGB(255, 187, 194, 205),
      ];
    }

    // Rain
    if (weatherCode >= 51 && weatherCode <= 67) {
      return const [
        Color(0xFF4B79A1),
        Color(0xFF283E51),
      ];
    }

    // Snow
    if (weatherCode >= 71 && weatherCode <= 77) {
      return const [
        Color.fromARGB(255, 149, 185, 239),
        Color.fromARGB(255, 206, 210, 211),
      ];
    }

    // Thunderstorm
    if (weatherCode >= 95) {
      return const [
        Color(0xFF2C3E50),
        Color(0xFF4CA1AF),
      ];
    }

    // Default
    return const [
      Color(0xFF4A90E2),
      Color(0xFF50C9C3),
    ];
  }
}
