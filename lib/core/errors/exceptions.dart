/// Base class for all exceptions in the application
class AppException implements Exception {
  final String message;

  const AppException(this.message);

  @override
  String toString() => message;
}

/// Exception when there's no internet connection
class NetworkException extends AppException {
  const NetworkException([super.message = 'No internet connection']);
}

/// Exception when location services are disabled
class LocationServiceException extends AppException {
  const LocationServiceException(
      [super.message = 'Location services are disabled']);
}

/// Exception when location permission is denied
class LocationPermissionException extends AppException {
  const LocationPermissionException(
      [super.message = 'Location permission denied']);
}

/// Exception when API returns an error
class ServerException extends AppException {
  const ServerException([super.message = 'Server error occurred']);
}

/// Exception when data parsing fails
class DataParsingException extends AppException {
  const DataParsingException([super.message = 'Failed to parse data']);
}

/// Exception when cached data is not found
class CacheException extends AppException {
  const CacheException([super.message = 'No cached data']);
}
