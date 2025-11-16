import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import '../../domain/entities/weather.dart';
import '../../../../core/utils/helpers.dart';
import 'glass_widgets.dart';

class DailyForecastList extends StatelessWidget {
  final List<DailyWeather> dailyForecast;
  final bool isDaytime;

  const DailyForecastList({
    super.key,
    required this.dailyForecast,
    required this.isDaytime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            '7-Day Forecast6666666',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: dailyForecast.length,
          itemBuilder: (context, index) {
            final daily = dailyForecast[index];
            return _DailyCard(
              daily: daily,
              isDaytime: isDaytime,
              delay: index * 100,
            );
          },
        ),
      ],
    );
  }
}

class _DailyCard extends StatelessWidget {
  final DailyWeather daily;
  final bool isDaytime;
  final int delay;

  const _DailyCard({
    required this.daily,
    required this.isDaytime,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    final isToday = daily.date.day == DateTime.now().day;

    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Day name
          Expanded(
            flex: 2,
            child: Text(
              isToday
                  ? 'Today'
                  : DateTimeHelper.getDayNameShort(
                      daily.date.toIso8601String()),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                  ),
            ),
          ),

          // Weather icon
          SizedBox(
            width: 50,
            height: 50,
            child: Lottie.asset(
              WeatherHelper.getWeatherAnimation(daily.weatherCode, isDaytime),
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(width: 16),

          // Min temperature
          Expanded(
            child: Row(
              children: [
                Icon(
                  Icons.thermostat,
                  size: 16,
                  color: Colors.blue.shade300,
                ),
                const SizedBox(width: 4),
                Text(
                  '${daily.minTemperature.round()}°',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.blue.shade300,
                      ),
                ),
              ],
            ),
          ),

          // Max temperature
          Expanded(
            child: Row(
              children: [
                Icon(
                  Icons.thermostat,
                  size: 16,
                  color: Colors.orange.shade300,
                ),
                const SizedBox(width: 4),
                Text(
                  '${daily.maxTemperature.round()}°',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.orange.shade300,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),

          // UV Index badge
          if (daily.uvIndex > 5)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getUVColor(daily.uvIndex).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _getUVColor(daily.uvIndex),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.wb_sunny,
                    size: 14,
                    color: _getUVColor(daily.uvIndex),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    daily.uvIndex.toStringAsFixed(0),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: _getUVColor(daily.uvIndex),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
        ],
      ),
    ).animate().fadeIn(delay: delay.ms).slideX(begin: -0.2, end: 0);
  }

  Color _getUVColor(double uvIndex) {
    if (uvIndex < 3) return Colors.green;
    if (uvIndex < 6) return Colors.yellow;
    if (uvIndex < 8) return Colors.orange;
    if (uvIndex < 11) return Colors.red;
    return Colors.purple;
  }
}
