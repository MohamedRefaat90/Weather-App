import '../../../../core/utils/result.dart';
import '../entities/location.dart';
import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetWeatherUseCase {
  final WeatherRepository repository;

  GetWeatherUseCase(this.repository);

  Future<Result<Weather>> call(Location location) {
    return repository.getWeather(location);
  }
}
