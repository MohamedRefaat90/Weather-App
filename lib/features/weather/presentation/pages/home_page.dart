import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../providers/weather_provider.dart';
import '../widgets/daily_forecast_section.dart';
import '../widgets/glass_widgets.dart';
import '../widgets/hourly_forecast_list.dart';
import '../widgets/weather_card.dart';
import '../widgets/weather_details_card.dart';
import '../widgets/weather_search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:
          Provider.of<WeatherProvider>(context, listen: true).state.status ==
                  WeatherStatus.loading
              ? AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  title: const Text(
                    'Weather App',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  iconTheme: const IconThemeData(color: Colors.white),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        showSearch(
                          context: context,
                          delegate: WeatherSearchDelegate(),
                        );
                      },
                      tooltip: 'Search location',
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        Provider.of<WeatherProvider>(context, listen: false)
                            .refreshWeather();
                      },
                      tooltip: 'Refresh',
                    ),
                  ],
                )
              : null,
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, _) {
          final state = weatherProvider.state;

          // Determine background gradient

          final backgroundGradient = state.weather != null
              ? _getWeatherGradient(
                  state.weather!.weatherCode,
                  _isDaytime(state.weather!.sunrise, state.weather!.sunset),
                )
              : _getDefaultGradient();

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: backgroundGradient,
              ),
            ),
            child: SafeArea(
              child: _buildBody(weatherProvider),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Load weather on app start
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherProvider>().getCurrentLocationWeather();
    });
  }

  Widget _buildBody(WeatherProvider provider) {
    final state = provider.state;

    if (state.status == WeatherStatus.loading) {
      return Center(
        child: Lottie.asset("assets/loader.json"),
      );
    }

    if (state.status == WeatherStatus.error) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: GlassCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.redAccent,
                ),
                const SizedBox(height: 16),
                Text(
                  'Oops!',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  state.failure?.message ?? 'An error occurred',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: provider.retry,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Try Again'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (state.weather == null) {
      return const Center(
        child: Text(
          'No weather data available',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    final weather = state.weather!;
    final isDaytime = _isDaytime(weather.sunrise, weather.sunset);

    return RefreshIndicator(
      onRefresh: () => provider.refreshWeather(),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main Weather Card
                WeatherCard(
                  weather: weather,
                  isDaytime: isDaytime,
                ),

                // Weather Details Card
                WeatherDetailsCard(weather: weather),

                // Hourly Forecast Section
                HourlyForecastList(
                  hourlyForecast: weather.hourlyForecast,
                  isDaytime: isDaytime,
                ),

                // Daily Forecast Section with Chart Toggle
                DailyForecastSection(
                  dailyForecast: weather.dailyForecast,
                  isDaytime: isDaytime,
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Color> _getDefaultGradient() {
    return const [
      Color(0xFF4A90E2),
      Color(0xFF50C9C3),
    ];
  }

  List<Color> _getWeatherGradient(int weatherCode, bool isDaytime) {
    if (!isDaytime) {
      return [
        const Color(0xFF0F2027),
        const Color(0xFF203A43),
        const Color(0xFF2C5364),
      ];
    }

    // Clear/Sunny
    if (weatherCode >= 0 && weatherCode <= 1) {
      return [
        const Color(0xFF56CCF2),
        const Color(0xFF2F80ED),
      ];
    }

    // Partly Cloudy
    if (weatherCode == 2) {
      return [
        const Color(0xFF89ABE3),
        const Color(0xFFEA738D),
      ];
    }

    // Cloudy/Overcast
    if (weatherCode == 3) {
      return [
        const Color(0xFF757F9A),
        const Color(0xFFD7DDE8),
      ];
    }

    // Rain
    if (weatherCode >= 51 && weatherCode <= 67) {
      return [
        const Color(0xFF4B79A1),
        const Color(0xFF283E51),
      ];
    }

    // Snow
    if (weatherCode >= 71 && weatherCode <= 77) {
      return [
        const Color(0xFFE0EAFC),
        const Color(0xFFCFDEF3),
      ];
    }

    // Thunderstorm
    if (weatherCode >= 95) {
      return [
        const Color(0xFF2C3E50),
        const Color(0xFF4CA1AF),
      ];
    }

    // Default
    return [
      const Color(0xFF4A90E2),
      const Color(0xFF50C9C3),
    ];
  }

  bool _isDaytime(DateTime sunrise, DateTime sunset) {
    final now = DateTime.now();
    return now.isAfter(sunrise) && now.isBefore(sunset);
  }
}
