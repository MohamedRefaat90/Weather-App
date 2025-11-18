import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../domain/entities/weather.dart';
import 'forecast/daily_forecast_chart.dart';
import 'forecast/daily_forecast_list.dart';
import 'forecast/view_toggle_button.dart';

class DailyForecastSection extends StatefulWidget {
  final List<DailyWeather> dailyForecast;
  final bool isDaytime;

  const DailyForecastSection({
    super.key,
    required this.dailyForecast,
    required this.isDaytime,
  });

  @override
  State<DailyForecastSection> createState() => _DailyForecastSectionState();
}

enum ForecastViewMode { list, chart }

class _DailyForecastSectionState extends State<DailyForecastSection> {
  ForecastViewMode _viewMode = ForecastViewMode.list;

  @override
  Widget build(BuildContext context) {
    final textColor = Colors.white.withOpacity(0.9);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with toggle
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '7-Day Forecast',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              // Toggle buttons
              Container(
                decoration: BoxDecoration(
                  color: textColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ViewToggleButton(
                      icon: Icons.list,
                      isSelected: _viewMode == ForecastViewMode.list,
                      onTap: () {
                        setState(() => _viewMode = ForecastViewMode.list);
                      },
                    ),
                    ViewToggleButton(
                      icon: Icons.show_chart,
                      isSelected: _viewMode == ForecastViewMode.chart,
                      onTap: () {
                        setState(() => _viewMode = ForecastViewMode.chart);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Animated view switcher
        AnimatedSwitcher(
          duration: 400.ms,
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.1),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: _viewMode == ForecastViewMode.list
              ? DailyForecastList(
                  key: const ValueKey('list'),
                  dailyForecast: widget.dailyForecast,
                  isDaytime: widget.isDaytime,
                )
              : DailyForecastChart(
                  key: const ValueKey('chart'),
                  dailyForecast: widget.dailyForecast,
                ),
        ),
      ],
    );
  }
}
