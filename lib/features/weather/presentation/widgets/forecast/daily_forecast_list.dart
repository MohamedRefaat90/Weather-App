import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/helpers.dart';
import '../../../domain/entities/weather.dart';
import '../glass_widgets.dart';

/// List view for daily forecast
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
      children: dailyForecast.take(7).map((daily) {
        return GlassCard(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Day
              Expanded(
                flex: 2,
                child: Text(
                  DateTimeHelper.formatDayOfWeek(daily.date),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.backgroundLight),
                ),
              ),

              // Weather icon
              SizedBox(
                width: 50,
                height: 50,
                child: Lottie.asset(WeatherHelper.getWeatherAnimation(
                    daily.weatherCode, isDaytime)),
              ),
              const SizedBox(width: 16),

              // Temperature range
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${daily.maxTemperature.round()}°',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.backgroundLight),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${daily.minTemperature.round()}°',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.backgroundLight.withOpacity(0.6),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(delay: (50).ms * dailyForecast.indexOf(daily))
            .slideX(
              begin: 0.1,
              end: 0,
            );
      }).toList(),
    );
  }
}
