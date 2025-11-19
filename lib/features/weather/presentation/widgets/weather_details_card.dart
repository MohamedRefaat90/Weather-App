import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../domain/entities/weather.dart';
import 'glass_widgets.dart';

class DateTimeHelper {
  static String formatTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

class WeatherDetailsCard extends StatelessWidget {
  final Weather weather;

  const WeatherDetailsCard({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    // final isDaytime = DateTime.now().isAfter(weather.sunrise) &&
    //     DateTime.now().isBefore(weather.sunset);
    final accentColor = Colors.white;
    return GlassCard(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gradientColors: [
        Colors.white.withOpacity(0.15),
        Colors.white.withOpacity(0.05),
      ],
      child: Column(
        children: [
          Text(
            'Weather Details',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 16),
          _buildDetailRow(
            context,
            icon: Icons.air,
            label: 'Wind Speed',
            value: '${weather.windSpeed.toStringAsFixed(1)} km/h',
            delay: 100,
            accentColor: accentColor,
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            context,
            icon: Icons.water_drop,
            label: 'Humidity',
            value: '${weather.humidity.round()}%',
            delay: 200,
            accentColor: accentColor,
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            context,
            icon: Icons.visibility,
            label: 'Visibility',
            value: '${(weather.visibility / 1000).toStringAsFixed(1)} km',
            delay: 300,
            accentColor: accentColor,
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            context,
            icon: Icons.wb_sunny,
            label: 'UV Index',
            value: weather.uvIndex.toStringAsFixed(1),
            delay: 400,
            accentColor: accentColor,
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            context,
            icon: Icons.wb_twilight,
            label: 'Sunrise',
            value: DateTimeHelper.formatTime(weather.sunrise),
            delay: 500,
            accentColor: accentColor,
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            context,
            icon: Icons.nights_stay,
            label: 'Sunset',
            value: DateTimeHelper.formatTime(weather.sunset),
            delay: 600,
            accentColor: accentColor,
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
    required Color accentColor,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: accentColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: accentColor,
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
                .copyWith(color: Colors.white.withOpacity(0.9)),
          ),
        ),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ],
    ).animate().fadeIn(delay: delay.ms).slideX(begin: 0.2, end: 0);
  }
}
