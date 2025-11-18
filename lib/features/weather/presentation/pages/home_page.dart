import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../providers/weather_provider.dart';
import '../widgets/daily_forecast_section.dart';
import '../widgets/debug_controls.dart';
import '../widgets/glass_widgets.dart';
import '../widgets/hourly_forecast_list.dart';
import '../widgets/search_overlay.dart';
import '../widgets/weather_background.dart';
import '../widgets/weather_card.dart';
import '../widgets/weather_details_card.dart';
import '../widgets/weather_overlay.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Debug mode for testing gradients
  bool _debugMode = false;
  int _debugWeatherCode = 0;
  bool _debugIsDaytime = true;
  bool _showSearchOverlay = false;

  // Weather codes for testing: Clear, Partly Cloudy, Cloudy, Rain, Snow, Thunderstorm
  final List<Map<String, dynamic>> _debugWeatherCodes = [
    {'code': 0, 'name': 'Clear (Day)', 'isDaytime': true},
    {'code': 0, 'name': 'Clear (Night)', 'isDaytime': false},
    {'code': 2, 'name': 'Partly Cloudy (Day)', 'isDaytime': true},
    {'code': 2, 'name': 'Partly Cloudy (Night)', 'isDaytime': false},
    {'code': 3, 'name': 'Cloudy (Day)', 'isDaytime': true},
    {'code': 3, 'name': 'Cloudy (Night)', 'isDaytime': false},
    {'code': 61, 'name': 'Rain (Day)', 'isDaytime': true},
    {'code': 61, 'name': 'Rain (Night)', 'isDaytime': false},
    {'code': 71, 'name': 'Snow (Day)', 'isDaytime': true},
    {'code': 71, 'name': 'Snow (Night)', 'isDaytime': false},
    {'code': 95, 'name': 'Thunderstorm (Day)', 'isDaytime': true},
    {'code': 95, 'name': 'Thunderstorm (Night)', 'isDaytime': false},
  ];
  int _currentDebugIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:
          Provider.of<WeatherProvider>(context, listen: true).state.status ==
                  WeatherStatus.success
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
                        setState(() {
                          _showSearchOverlay = true;
                        });
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
                    IconButton(
                      icon: Icon(_debugMode
                          ? Icons.bug_report
                          : Icons.bug_report_outlined),
                      onPressed: () {
                        setState(() {
                          _debugMode = !_debugMode;
                        });
                      },
                      tooltip: 'Toggle Debug Mode',
                    ),
                  ],
                )
              : null,
      body: Stack(
        children: [
          // Main content
          Consumer<WeatherProvider>(
            builder: (context, weatherProvider, _) {
              final state = weatherProvider.state;

              return state.weather != null
                  ? Stack(
                      children: [
                        // Background gradient
                        WeatherBackground(
                          weatherCode: _debugMode
                              ? _debugWeatherCode
                              : state.weather!.weatherCode,
                          isDaytime: _debugMode
                              ? _debugIsDaytime
                              : _isDaytime(state.weather!.sunrise,
                                  state.weather!.sunset),
                          child: SafeArea(
                            child: _buildBody(weatherProvider),
                          ),
                        ),

                        // Weather overlays (rain/snow)
                        WeatherOverlay(
                          weatherCode: _debugMode
                              ? _debugWeatherCode
                              : state.weather!.weatherCode,
                        ),
                      ],
                    )
                  : Center(
                      child: Lottie.asset("assets/loader.json",
                          frameRate: FrameRate(60)),
                    );
            },
          ),

          // Search overlay
          if (_showSearchOverlay)
            SearchOverlay(
              onClose: () {
                setState(() {
                  _showSearchOverlay = false;
                });
              },
            ),

          // Debug controls
          if (_debugMode)
            Positioned(
              bottom: 80,
              right: 16,
              left: 16,
              child: DebugControls(
                debugMode: _debugMode,
                currentDebugIndex: _currentDebugIndex,
                debugWeatherCodes: _debugWeatherCodes,
                onToggleDebug: () {
                  setState(() {
                    _debugMode = !_debugMode;
                  });
                },
                onCycleWeather: _cycleDebugWeather,
              ),
            ),
        ],
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
                  debugWeatherCode: _debugMode ? _debugWeatherCode : null,
                  debugIsDaytime: _debugMode ? _debugIsDaytime : null,
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

  void _cycleDebugWeather() {
    setState(() {
      _currentDebugIndex = (_currentDebugIndex + 1) % _debugWeatherCodes.length;
      _debugWeatherCode = _debugWeatherCodes[_currentDebugIndex]['code'];
      _debugIsDaytime = _debugWeatherCodes[_currentDebugIndex]['isDaytime'];
    });
  }

  bool _isDaytime(DateTime sunrise, DateTime sunset) {
    final now = DateTime.now();
    return now.isAfter(sunrise) && now.isBefore(sunset);
  }
}
