import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/helpers.dart';
import '../../domain/entities/weather.dart';
import 'glass_widgets.dart';
import 'temperature_badge.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;
  final bool isDaytime;
  final int? debugWeatherCode;
  final bool? debugIsDaytime;

  const WeatherCard({
    super.key,
    required this.weather,
    required this.isDaytime,
    this.debugWeatherCode,
    this.debugIsDaytime,
  });

  @override
  Widget build(BuildContext context) {
    final gradientColors = WeatherHelper.getMainWeatherCardGradient(
      debugWeatherCode ?? weather.weatherCode,
      debugIsDaytime ?? isDaytime,
    );

    // Check if it's snowy weather to use darker text colors
    final effectiveWeatherCode = debugWeatherCode ?? weather.weatherCode;
    final isSnowy = _isSnowyWeather(effectiveWeatherCode);
    final textColor = isSnowy ? Colors.black87 : Colors.white;
    final subtextColor =
        isSnowy ? Colors.black54 : Colors.white.withOpacity(0.9);

    return Hero(
      tag: 'weather-card',
      child: GradientCard(
        gradientColors: gradientColors,
        margin: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Location
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on, color: textColor, size: 20),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    weather.cityName,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 100.ms).slideY(begin: -0.2, end: 0),

            const SizedBox(height: 8),

            // Country
            Text(
              weather.country,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: subtextColor,
                  ),
            ).animate().fadeIn(delay: 200.ms),

            const SizedBox(height: 24),

            // Weather animation
            SizedBox(
              height: 150,
              child: Lottie.asset(
                WeatherHelper.getWeatherAnimation(
                  debugWeatherCode ?? weather.weatherCode,
                  debugIsDaytime ?? isDaytime,
                ),
                fit: BoxFit.contain,
              ),
            ).animate().scale(delay: 300.ms, duration: 600.ms),

            const SizedBox(height: 16),

            // Temperature
            Text(
              '${weather.temperature.round()}°',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 72,
                    height: 1,
                  ),
            ).animate().fadeIn(delay: 400.ms).scale(duration: 400.ms),

            const SizedBox(height: 8),

            // Weather description
            Text(
              WeatherCodeDescriptions.getDescription(weather.weatherCode),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: subtextColor,
                  ),
            ).animate().fadeIn(delay: 500.ms),

            const SizedBox(height: 16),

            // Min/Max temperature
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TemperatureBadge(
                  label: 'Max',
                  temperature: weather.dailyForecast.first.maxTemperature,
                  icon: Icons.arrow_upward,
                  isSnowy: isSnowy,
                ),
                const SizedBox(width: 16),
                TemperatureBadge(
                  label: 'Min',
                  temperature: weather.dailyForecast.first.minTemperature,
                  icon: Icons.arrow_downward,
                  isSnowy: isSnowy,
                ),
              ],
            ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2, end: 0),
          ],
        ),
      ),
    );
  }

  bool _isSnowyWeather(int weatherCode) {
    // Check for snow fall (71-77) and snow showers (85-86)
    return (weatherCode >= 71 && weatherCode <= 77) ||
        (weatherCode >= 85 && weatherCode <= 86);
  }
}
