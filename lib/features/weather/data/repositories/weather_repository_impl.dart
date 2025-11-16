import '../../domain/entities/weather.dart';
import '../../domain/entities/location.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_remote_datasource.dart';
import '../datasources/weather_local_datasource.dart';
import '../datasources/location_datasource.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/exceptions.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localDataSource;
  final LocationDataSource locationDataSource;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.locationDataSource,
  });

  @override
  Future<Result<Weather>> getWeather(Location location) async {
    try {
      final weather = await remoteDataSource.getWeather(
        latitude: location.latitude,
        longitude: location.longitude,
        cityName: location.cityName,
        country: location.country,
      );

      // Cache the weather data
      await localDataSource.cacheWeather(weather);

      return Success(weather);
    } on NetworkException catch (e) {
      return Error(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Error(ServerFailure(e.message));
    } on DataParsingException catch (e) {
      return Error(DataParsingFailure(e.message));
    } catch (e) {
      return Error(UnknownFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Result<Weather>> getWeatherByCurrentLocation() async {
    try {
      // Get current location
      final locationResult = await locationDataSource.getCurrentLocation();

      // Fetch weather for that location
      final weather = await remoteDataSource.getWeather(
        latitude: locationResult.latitude,
        longitude: locationResult.longitude,
        cityName: locationResult.cityName,
        country: locationResult.country,
      );

      // Cache the weather data
      await localDataSource.cacheWeather(weather);

      return Success(weather);
    } on LocationServiceException catch (e) {
      return Error(LocationServiceFailure(e.message));
    } on LocationPermissionException catch (e) {
      return Error(LocationPermissionFailure(e.message));
    } on NetworkException catch (e) {
      return Error(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Error(ServerFailure(e.message));
    } on DataParsingException catch (e) {
      return Error(DataParsingFailure(e.message));
    } catch (e) {
      return Error(UnknownFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Result<Weather>> getCachedWeather() async {
    try {
      final weather = await localDataSource.getCachedWeather();
      return Success(weather);
    } on CacheException catch (e) {
      return Error(CacheFailure(e.message));
    } catch (e) {
      return Error(UnknownFailure('Failed to get cached weather: $e'));
    }
  }

  @override
  Future<Result<void>> cacheWeather(Weather weather) async {
    try {
      // Convert entity to model (assuming weather is already a WeatherModel)
      await localDataSource.cacheWeather(weather as dynamic);
      return const Success(null);
    } on CacheException catch (e) {
      return Error(CacheFailure(e.message));
    } catch (e) {
      return Error(UnknownFailure('Failed to cache weather: $e'));
    }
  }

  @override
  Future<bool> isCacheValid() async {
    return await localDataSource.isCacheValid();
  }
}
