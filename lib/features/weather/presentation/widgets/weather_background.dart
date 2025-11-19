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
        Color(0xFF141E30), // Dark Blue
        Color(0xFF243B55), // Deep Teal
      ];
    }

    // Clear/Sunny
    if (weatherCode >= 0 && weatherCode <= 1) {
      return const [
        Color.fromARGB(255, 79, 172, 254), // Bright Blue
        Color.fromARGB(255, 0, 241, 254), // Bright Cyan
        Color.fromARGB(255, 226, 226, 226), // White hint at bottom
      ];
    }

    // Partly Cloudy
    if (weatherCode == 2) {
      return const [
        Color(0xFF56CCF2),
        Color(0xFF2F80ED),
      ];
    }

    // Cloudy/Overcast
    if (weatherCode == 3) {
      return const [
        Color(0xFF757F9A),
        Color(0xFFD7DDE8),
      ];
    }

    // Rain
    if (weatherCode >= 51 && weatherCode <= 67) {
      return const [
        Color(0xFF373B44),
        Color(0xFF4286f4),
      ];
    }

    // Snow
    if (weatherCode >= 71 && weatherCode <= 77) {
      return const [
        Color(0xFFE6DADA),
        Color(0xFF274046),
      ];
    }

    // Thunderstorm
    if (weatherCode >= 95) {
      return const [
        Color(0xFF000000),
        Color(0xFF434343),
      ];
    }

    // Default
    return const [
      Color(0xFF4A90E2),
      Color(0xFF50C9C3),
    ];
  }
}
