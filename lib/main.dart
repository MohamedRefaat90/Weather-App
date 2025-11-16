import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/di/dependency_injection.dart';
import 'core/theme/app_theme.dart';
import 'features/weather/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  await DependencyInjection.init();

  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
            value: DependencyInjection.weatherProvider),
        ChangeNotifierProvider.value(
            value: DependencyInjection.locationProvider),
        ChangeNotifierProvider.value(
            value: DependencyInjection.favoritesProvider),
      ],
      child: MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const HomePage(),
      ),
    );
  }
}
