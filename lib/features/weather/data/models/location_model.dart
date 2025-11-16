import '../../domain/entities/location.dart';

class LocationModel extends Location {
  const LocationModel({
    required super.latitude,
    required super.longitude,
    required super.cityName,
    required super.country,
  });

  factory LocationModel.fromPlacemark(
    double latitude,
    double longitude,
    String? locality,
    String? administrativeArea,
    String? country,
  ) {
    return LocationModel(
      latitude: latitude,
      longitude: longitude,
      cityName: locality ?? administrativeArea ?? 'Unknown',
      country: country ?? 'Unknown',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'cityName': cityName,
      'country': country,
    };
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      cityName: json['cityName'] as String,
      country: json['country'] as String,
    );
  }
}
