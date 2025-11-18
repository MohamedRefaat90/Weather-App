import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../core/utils/helpers.dart';
import '../../../domain/entities/weather.dart';
import '../glass_widgets.dart';

/// Chart view for daily forecast temperatures
class DailyForecastChart extends StatelessWidget {
  final List<DailyWeather> dailyForecast;

  const DailyForecastChart({
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
                      const TextStyle(
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
              _buildTemperatureLine(
                dailyForecast,
                isMaxTemp: true,
                color: Colors.red,
              ),
              _buildTemperatureLine(
                dailyForecast,
                isMaxTemp: false,
                color: Colors.blue,
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

  LineChartBarData _buildTemperatureLine(
    List<DailyWeather> forecast, {
    required bool isMaxTemp,
    required Color color,
  }) {
    return LineChartBarData(
      spots: forecast
          .asMap()
          .entries
          .map((e) => FlSpot(
                e.key.toDouble(),
                isMaxTemp ? e.value.maxTemperature : e.value.minTemperature,
              ))
          .toList(),
      isCurved: true,
      color: color.withOpacity(0.8),
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) {
          return FlDotCirclePainter(
            radius: 4,
            color: color,
            strokeWidth: 2,
            strokeColor: Colors.white,
          );
        },
      ),
      belowBarData: BarAreaData(
        show: true,
        color: color.withOpacity(0.1),
      ),
    );
  }
}
