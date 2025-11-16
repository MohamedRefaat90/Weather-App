import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import '../../domain/entities/weather.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../core/constants/app_constants.dart';
import 'glass_widgets.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;
  final bool isDaytime;

  const WeatherCard({
    super.key,
    required this.weather,
    required this.isDaytime,
  });

  @override
  Widget build(BuildContext context) {
    final gradientColors = WeatherHelper.getWeatherGradient(
      weather.weatherCode,
      isDaytime,
    );

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
                const Icon(Icons.location_on, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    weather.cityName,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
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
                    color: Colors.white.withOpacity(0.9),
                  ),
            ).animate().fadeIn(delay: 200.ms),

            const SizedBox(height: 24),

            // Weather animation
            SizedBox(
              height: 150,
              child: Lottie.asset(
                WeatherHelper.getWeatherAnimation(
                    weather.weatherCode, isDaytime),
                fit: BoxFit.contain,
              ),
            ).animate().scale(delay: 300.ms, duration: 600.ms),

            const SizedBox(height: 16),

            // Temperature
            Text(
              '${weather.temperature.round()}°',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.white,
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
                    color: Colors.white.withOpacity(0.9),
                  ),
            ).animate().fadeIn(delay: 500.ms),

            const SizedBox(height: 16),

            // Min/Max temperature
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTempBadge(
                  context,
                  'Max',
                  weather.dailyForecast.first.maxTemperature,
                  Icons.arrow_upward,
                ),
                const SizedBox(width: 16),
                _buildTempBadge(
                  context,
                  'Min',
                  weather.dailyForecast.first.minTemperature,
                  Icons.arrow_downward,
                ),
              ],
            ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2, end: 0),
          ],
        ),
      ),
    );
  }

  Widget _buildTempBadge(
    BuildContext context,
    String label,
    double temp,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
          ),
          const SizedBox(width: 8),
          Text(
            '${temp.round()}°',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
