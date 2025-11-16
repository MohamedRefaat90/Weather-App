import '../../../../core/utils/result.dart';
import '../entities/location.dart';
import '../repositories/location_repository.dart';

class SearchLocationUseCase {
  final LocationRepository repository;

  SearchLocationUseCase(this.repository);

  Future<Result<Location>> call(String cityName) {
    return repository.searchLocation(cityName);
  }
}
