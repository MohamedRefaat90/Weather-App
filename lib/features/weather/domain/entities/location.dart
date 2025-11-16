import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final double latitude;
  final double longitude;
  final String cityName;
  final String country;

  const Location({
    required this.latitude,
    required this.longitude,
    required this.cityName,
    required this.country,
  });

  @override
  List<Object?> get props => [latitude, longitude, cityName, country];
}
