import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:weather/core/theme/app_theme.dart';
import '../../domain/entities/weather.dart';
import 'glass_widgets.dart';

class WeatherDetailsCard extends StatelessWidget {
  final Weather weather;

  const WeatherDetailsCard({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Text(
            'Weather Details',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold, color: AppColors.backgroundLight),
          ),
          const SizedBox(height: 16),
          _buildDetailRow(
            context,
            icon: Icons.air,
            label: 'Wind Speed',
            value: '${weather.windSpeed.toStringAsFixed(1)} km/h',
            delay: 100,
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            context,
            icon: Icons.water_drop,
            label: 'Humidity',
            value: '${weather.humidity.round()}%',
            delay: 200,
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            context,
            icon: Icons.visibility,
            label: 'Visibility',
            value: '${(weather.visibility / 1000).toStringAsFixed(1)} km',
            delay: 300,
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            context,
            icon: Icons.wb_sunny,
            label: 'UV Index',
            value: weather.uvIndex.toStringAsFixed(1),
            delay: 400,
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            context,
            icon: Icons.wb_twilight,
            label: 'Sunrise',
            value: DateTimeHelper.formatTime(weather.sunrise),
            delay: 500,
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            context,
            icon: Icons.nights_stay,
            label: 'Sunset',
            value: DateTimeHelper.formatTime(weather.sunset),
            delay: 600,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required int delay,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: AppColors.backgroundLight),
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold, color: AppColors.backgroundLight),
        ),
      ],
    ).animate().fadeIn(delay: delay.ms).slideX(begin: 0.2, end: 0);
  }
}

class DateTimeHelper {
  static String formatTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
