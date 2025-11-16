import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/location.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/favorites_local_datasource.dart';
import '../datasources/location_datasource.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSource locationDataSource;
  final FavoritesLocalDataSource favoritesDataSource;

  LocationRepositoryImpl({
    required this.locationDataSource,
    required this.favoritesDataSource,
  });

  @override
  Future<Result<void>> addFavoriteCity(String cityName) async {
    try {
      await favoritesDataSource.addFavoriteCity(cityName);
      return const Success(null);
    } on CacheException catch (e) {
      return Error(CacheFailure(e.message));
    } catch (e) {
      return Error(UnknownFailure('Failed to add favorite: $e'));
    }
  }

  @override
  Future<Result<Location>> getCurrentLocation() async {
    try {
      final location = await locationDataSource.getCurrentLocation();
      return Success(location);
    } on LocationServiceException catch (e) {
      return Error(LocationServiceFailure(e.message));
    } on LocationPermissionException catch (e) {
      return Error(LocationPermissionFailure(e.message));
    } on DataParsingException catch (e) {
      return Error(DataParsingFailure(e.message));
    } catch (e) {
      return Error(UnknownFailure('Failed to get current location: $e'));
    }
  }

  @override
  Future<Result<List<String>>> getFavoriteCities() async {
    try {
      final favorites = await favoritesDataSource.getFavoriteCities();
      return Success(favorites);
    } on CacheException catch (e) {
      return Error(CacheFailure(e.message));
    } catch (e) {
      return Error(UnknownFailure('Failed to get favorites: $e'));
    }
  }

  @override
  Future<bool> isLocationServiceEnabled() async {
    return await locationDataSource.isLocationServiceEnabled();
  }

  @override
  Future<Result<void>> removeFavoriteCity(String cityName) async {
    try {
      await favoritesDataSource.removeFavoriteCity(cityName);
      return const Success(null);
    } on CacheException catch (e) {
      return Error(CacheFailure(e.message));
    } catch (e) {
      return Error(UnknownFailure('Failed to remove favorite: $e'));
    }
  }

  @override
  Future<Result<bool>> requestLocationPermission() async {
    try {
      final granted = await locationDataSource.requestLocationPermission();
      return Success(granted);
    } catch (e) {
      return Error(LocationPermissionFailure('Failed to request permission: $e'));
    }
  }

  @override
  Future<Result<Location>> searchLocation(String cityName) async {
    try {
      final location = await locationDataSource.searchLocation(cityName);
      return Success(location);
    } on DataParsingException catch (e) {
      return Error(DataParsingFailure(e.message));
    } catch (e) {
      return Error(UnknownFailure('Failed to search location: $e'));
    }
  }
}
