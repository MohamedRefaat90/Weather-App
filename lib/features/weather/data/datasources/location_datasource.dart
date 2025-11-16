import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/location_model.dart';

abstract class LocationDataSource {
  /// Get device's current location
  Future<LocationModel> getCurrentLocation();

  /// Check if location services are enabled
  Future<bool> isLocationServiceEnabled();

  /// Request location permission
  Future<bool> requestLocationPermission();

  /// Search for location by city name
  Future<LocationModel> searchLocation(String cityName);
}

class LocationDataSourceImpl implements LocationDataSource {
  @override
  Future<LocationModel> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      final serviceEnabled = await isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw const LocationServiceException('Location services are disabled');
      }

      // Check permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw const LocationPermissionException('Location permission denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw const LocationPermissionException(
          'Location permissions are permanently denied',
        );
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      // Get placemark from coordinates
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isEmpty) {
        throw const DataParsingException('Could not get location details');
      }

      final placemark = placemarks.first;

      return LocationModel.fromPlacemark(
        position.latitude,
        position.longitude,
        placemark.locality,
        placemark.administrativeArea,
        placemark.country,
      );
    } on LocationServiceException {
      rethrow;
    } on LocationPermissionException {
      rethrow;
    } catch (e) {
      throw DataParsingException('Failed to get current location: $e');
    }
  }

  @override
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  @override
  Future<bool> requestLocationPermission() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      return permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<LocationModel> searchLocation(String cityName) async {
    try {
      // Get location from address
      final locations = await locationFromAddress(cityName);

      if (locations.isEmpty) {
        throw DataParsingException('City "$cityName" not found');
      }

      final location = locations.first;

      // Get placemark details
      final placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );

      if (placemarks.isEmpty) {
        throw const DataParsingException('Could not get location details');
      }

      final placemark = placemarks.first;

      return LocationModel.fromPlacemark(
        location.latitude,
        location.longitude,
        placemark.locality,
        placemark.administrativeArea,
        placemark.country,
      );
    } catch (e) {
      if (e is DataParsingException) rethrow;
      throw DataParsingException('Failed to search location: $e');
    }
  }
}
