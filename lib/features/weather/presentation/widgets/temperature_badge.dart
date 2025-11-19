import 'package:flutter/material.dart';

/// Temperature badge widget for displaying min/max temperatures
class TemperatureBadge extends StatelessWidget {
  final String label;
  final double temperature;
  final IconData icon;
  final bool isSnowy;

  const TemperatureBadge({
    super.key,
    required this.label,
    required this.temperature,
    required this.icon,
    this.isSnowy = false,
  });

  @override
  Widget build(BuildContext context) {
    final badgeTextColor = isSnowy ? Colors.black87 : Colors.white;
    final badgeSubtextColor =
        isSnowy ? Colors.black54 : Colors.white.withOpacity(0.9);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: badgeTextColor, size: 18),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: badgeSubtextColor,
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(width: 8),
        Text(
          '${temperature.round()}°',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: badgeTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
        ),
      ],
    );
  }
}
