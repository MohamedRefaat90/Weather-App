import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/core/theme/app_theme.dart';

import '../../../../core/utils/helpers.dart';
import '../../domain/entities/weather.dart';
import 'glass_widgets.dart';

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

class _DailyForecastChart extends StatelessWidget {
  final List<DailyWeather> dailyForecast;

  const _DailyForecastChart({
    super.key,
    required this.dailyForecast,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Colors.white.withOpacity(0.9);

    return GlassCard(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: 250,
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(
              enabled: true,
              touchTooltipData: LineTouchTooltipData(
                getTooltipColor: (touchedSpot) => Colors.black87,
                tooltipRoundedRadius: 8,
                tooltipPadding: const EdgeInsets.all(15),
                fitInsideVertically: true,
                fitInsideHorizontally: true,
                getTooltipItems: (List<LineBarSpot> touchedSpots) {
                  return touchedSpots.map((spot) {
                    final isMaxTemp = spot.barIndex == 0;
                    return LineTooltipItem(
                      '${spot.y.round()}°\n',
                      TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: isMaxTemp ? 'High' : 'Low',
                          style: TextStyle(
                            color: isMaxTemp
                                ? Colors.red.shade300
                                : Colors.blue.shade300,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    );
                  }).toList();
                },
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 5,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: textColor.withOpacity(0.1),
                  strokeWidth: 1,
                );
              },
            ),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      '${value.toInt()}°',
                      style: TextStyle(
                        color: textColor.withOpacity(0.6),
                        fontSize: 12,
                      ),
                    );
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  getTitlesWidget: (value, meta) {
                    if (value.toInt() >= 0 &&
                        value.toInt() < dailyForecast.length) {
                      return Text(
                        DateTimeHelper.formatShortDay(
                            dailyForecast[value.toInt()].date),
                        style: TextStyle(
                          color: textColor.withOpacity(0.6),
                          fontSize: 12,
                        ),
                      );
                    }
                    return const Text('');
                  },
                ),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              // Max temperature line
              LineChartBarData(
                spots: dailyForecast
                    .asMap()
                    .entries
                    .map((e) => FlSpot(
                          e.key.toDouble(),
                          e.value.maxTemperature,
                        ))
                    .toList(),
                isCurved: true,
                color: Colors.red.withOpacity(0.8),
                barWidth: 3,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 4,
                      color: Colors.red,
                      strokeWidth: 2,
                      strokeColor: Colors.white,
                    );
                  },
                ),
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.red.withOpacity(0.1),
                ),
              ),
              // Min temperature line
              LineChartBarData(
                spots: dailyForecast
                    .asMap()
                    .entries
                    .map((e) => FlSpot(
                          e.key.toDouble(),
                          e.value.minTemperature,
                        ))
                    .toList(),
                isCurved: true,
                color: Colors.blue.withOpacity(0.8),
                barWidth: 3,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 4,
                      color: Colors.blue,
                      strokeWidth: 2,
                      strokeColor: Colors.white,
                    );
                  },
                ),
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.blue.withOpacity(0.1),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1, 1),
        );
  }
}

class _DailyForecastList extends StatelessWidget {
  final List<DailyWeather> dailyForecast;
  final bool isDaytime;

  const _DailyForecastList({
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
                    _ViewToggleButton(
                      icon: Icons.list,
                      isSelected: _viewMode == ForecastViewMode.list,
                      onTap: () {
                        setState(() => _viewMode = ForecastViewMode.list);
                      },
                    ),
                    _ViewToggleButton(
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
              ? _DailyForecastList(
                  key: const ValueKey('list'),
                  dailyForecast: widget.dailyForecast,
                  isDaytime: widget.isDaytime,
                )
              : _DailyForecastChart(
                  key: const ValueKey('chart'),
                  dailyForecast: widget.dailyForecast,
                ),
        ),
      ],
    );
  }
}

class _ViewToggleButton extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ViewToggleButton({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Colors.white.withOpacity(0.9);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 200.ms,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? textColor.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: isSelected ? textColor : textColor.withOpacity(0.5),
          size: 20,
        ),
      ),
    );
  }
}
