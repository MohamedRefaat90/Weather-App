import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/weather/data/datasources/favorites_local_datasource.dart';
import '../../features/weather/data/datasources/location_datasource.dart';
import '../../features/weather/data/datasources/weather_local_datasource.dart';
import '../../features/weather/data/datasources/weather_remote_datasource.dart';
import '../../features/weather/data/repositories/location_repository_impl.dart';
import '../../features/weather/data/repositories/weather_repository_impl.dart';
import '../../features/weather/domain/repositories/location_repository.dart';
import '../../features/weather/domain/repositories/weather_repository.dart';
import '../../features/weather/domain/usecases/get_current_location_weather.dart';
import '../../features/weather/domain/usecases/get_weather.dart';
import '../../features/weather/domain/usecases/manage_favorites.dart';
import '../../features/weather/domain/usecases/search_location.dart';
import '../../features/weather/presentation/providers/favorites_provider.dart';
import '../../features/weather/presentation/providers/location_provider.dart';
import '../../features/weather/presentation/providers/weather_provider.dart';

/// Dependency Injection Container
class DependencyInjection {
  static SharedPreferences? _sharedPreferences;
  static http.Client? _httpClient;

  // Data Sources
  static WeatherRemoteDataSource? _weatherRemoteDataSource;
  static WeatherLocalDataSource? _weatherLocalDataSource;
  static LocationDataSource? _locationDataSource;
  static FavoritesLocalDataSource? _favoritesLocalDataSource;

  // Repositories
  static WeatherRepository? _weatherRepository;
  static LocationRepository? _locationRepository;

  // Use Cases
  static GetWeatherUseCase? _getWeatherUseCase;
  static GetCurrentLocationWeatherUseCase? _getCurrentLocationWeatherUseCase;
  static SearchLocationUseCase? _searchLocationUseCase;
  static ManageFavoritesUseCase? _manageFavoritesUseCase;

  // Providers
  static WeatherProvider? _weatherProvider;
  static LocationProvider? _locationProvider;
  static FavoritesProvider? _favoritesProvider;

  static FavoritesProvider get favoritesProvider => _favoritesProvider!;

  static LocationProvider get locationProvider => _locationProvider!;
  // Getters
  static WeatherProvider get weatherProvider => _weatherProvider!;

  /// Dispose resources
  static void dispose() {
    _httpClient?.close();
  }

  /// Initialize all dependencies
  static Future<void> init() async {
    // External dependencies
    _sharedPreferences = await SharedPreferences.getInstance();
    _httpClient = http.Client();

    // Data sources
    _weatherRemoteDataSource =
        WeatherRemoteDataSourceImpl(client: _httpClient!);
    _weatherLocalDataSource = WeatherLocalDataSourceImpl(
      sharedPreferences: _sharedPreferences!,
    );
    _locationDataSource = LocationDataSourceImpl();
    _favoritesLocalDataSource = FavoritesLocalDataSourceImpl(
      sharedPreferences: _sharedPreferences!,
    );

    // Repositories
    _weatherRepository = WeatherRepositoryImpl(
      remoteDataSource: _weatherRemoteDataSource!,
      localDataSource: _weatherLocalDataSource!,
      locationDataSource: _locationDataSource!,
    );
    _locationRepository = LocationRepositoryImpl(
      locationDataSource: _locationDataSource!,
      favoritesDataSource: _favoritesLocalDataSource!,
    );

    // Use cases
    _getWeatherUseCase = GetWeatherUseCase(_weatherRepository!);
    _getCurrentLocationWeatherUseCase = GetCurrentLocationWeatherUseCase(
      _weatherRepository!,
    );
    _searchLocationUseCase = SearchLocationUseCase(_locationRepository!);
    _manageFavoritesUseCase = ManageFavoritesUseCase(_locationRepository!);

    // Providers
    _weatherProvider = WeatherProvider(
      getWeatherUseCase: _getWeatherUseCase!,
      getCurrentLocationWeatherUseCase: _getCurrentLocationWeatherUseCase!,
      weatherRepository: _weatherRepository!,
    );
    _locationProvider = LocationProvider(
      searchLocationUseCase: _searchLocationUseCase!,
      locationRepository: _locationRepository!,
    );
    _favoritesProvider = FavoritesProvider(
      manageFavoritesUseCase: _manageFavoritesUseCase!,
    );
  }
}
