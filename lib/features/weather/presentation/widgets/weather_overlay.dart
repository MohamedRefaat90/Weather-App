import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// Widget that displays weather overlay animations (rain, snow)
class WeatherOverlay extends StatelessWidget {
  final int weatherCode;

  const WeatherOverlay({
    super.key,
    required this.weatherCode,
  });

  @override
  Widget build(BuildContext context) {
    final overlayAnimation = _getOverlayAnimation(weatherCode);

    if (overlayAnimation == null) {
      return const SizedBox.shrink();
    }

    return Positioned.fill(
      child: IgnorePointer(
        child: Lottie.asset(
          overlayAnimation,
          fit: BoxFit.cover,
          repeat: true,
        ),
      ),
    );
  }

  String? _getOverlayAnimation(int weatherCode) {
    // Rain overlay: drizzle (51-57), rain (61-67), rain showers (80-82)
    if ((weatherCode >= 51 && weatherCode <= 67) ||
        (weatherCode >= 80 && weatherCode <= 82)) {
      return 'assets/icons/Rain_waves.json';
    }

    // Snow overlay: snow fall (71-77), snow showers (85-86)
    if ((weatherCode >= 71 && weatherCode <= 77) ||
        (weatherCode >= 85 && weatherCode <= 86)) {
      return 'assets/icons/Snow_waves.json';
    }

    return null;
  }
}
