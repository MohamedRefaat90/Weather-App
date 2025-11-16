import 'package:equatable/equatable.dart';

/// Failure when cached data is not found
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'No cached data available.']);
}

/// Failure when data parsing fails
class DataParsingFailure extends Failure {
  const DataParsingFailure([super.message = 'Failed to process weather data.']);
}

/// Base class for all failures in the application
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Failure when location permission is denied
class LocationPermissionFailure extends Failure {
  const LocationPermissionFailure(
      [super.message =
          'Location permission denied. Please grant location access.']);
}

/// Failure when location services are disabled
class LocationServiceFailure extends Failure {
  const LocationServiceFailure(
      [super.message =
          'Location services are disabled. Please enable location services.']);
}

/// Failure when there's no internet connection
class NetworkFailure extends Failure {
  const NetworkFailure(
      [super.message =
          'No internet connection. Please check your network settings.']);
}

/// Failure when API returns an error
class ServerFailure extends Failure {
  const ServerFailure(
      [super.message = 'Server error occurred. Please try again later.']);
}

/// Failure for unknown errors
class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'An unexpected error occurred.']);
}
