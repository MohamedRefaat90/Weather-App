import '../../../../core/utils/result.dart';
import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetCurrentLocationWeatherUseCase {
  final WeatherRepository repository;

  GetCurrentLocationWeatherUseCase(this.repository);

  Future<Result<Weather>> call() {
    return repository.getWeatherByCurrentLocation();
  }
}
