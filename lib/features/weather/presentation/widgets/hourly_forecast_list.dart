import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/utils/helpers.dart';
import '../../domain/entities/weather.dart';
import 'glass_widgets.dart';

class HourlyForecastList extends StatelessWidget {
  final List<HourlyWeather> hourlyForecast;
  final bool isDaytime;

  const HourlyForecastList({
    super.key,
    required this.hourlyForecast,
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
            'Hourly Forecast',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: hourlyForecast.take(24).length,
            itemBuilder: (context, index) {
              final hourly = hourlyForecast[index];
              final isCurrentHour = DateTimeHelper.isCurrentHour(
                hourly.time.toIso8601String(),
              );

              return _HourlyCard(
                hourly: hourly,
                isDaytime: isDaytime,
                isCurrentHour: isCurrentHour,
                delay: index * 50,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _HourlyCard extends StatelessWidget {
  final HourlyWeather hourly;
  final bool isDaytime;
  final bool isCurrentHour;
  final int delay;

  const _HourlyCard({
    required this.hourly,
    required this.isDaytime,
    required this.isCurrentHour,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    // Glass effect gradient
    final gradientColors = isCurrentHour
        ? [
            Colors.white.withOpacity(0.3),
            Colors.white.withOpacity(0.2),
          ]
        : [
            Colors.white.withOpacity(0.15),
            Colors.white.withOpacity(0.05),
          ];

    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      child: GlassCard(
        gradientColors: gradientColors,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              isCurrentHour ? "Now" : DateTimeHelper.formatHour(hourly.time),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontWeight:
                        isCurrentHour ? FontWeight.bold : FontWeight.w500,
                  ),
            ),
            SizedBox(
              height: 40,
              child: Lottie.asset(
                WeatherHelper.getWeatherAnimation(
                    hourly.weatherCode, isDaytime),
                fit: BoxFit.contain,
              ),
            ),
            Text(
              '${hourly.temperature.round()}°',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            if (hourly.precipitation > 0)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.water_drop,
                    size: 12,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  const SizedBox(width: 2),
                  Text(
                    '${hourly.precipitation.round()}%',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 10,
                        ),
                  ),
                ],
              ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: delay.ms).slideX(begin: 0.3, end: 0);
  }
}
