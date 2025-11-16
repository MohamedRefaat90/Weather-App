import '../../../../core/utils/result.dart';
import '../repositories/location_repository.dart';

class ManageFavoritesUseCase {
  final LocationRepository repository;

  ManageFavoritesUseCase(this.repository);

  Future<Result<void>> addFavorite(String cityName) {
    return repository.addFavoriteCity(cityName);
  }

  Future<Result<List<String>>> getFavorites() {
    return repository.getFavoriteCities();
  }

  Future<Result<void>> removeFavorite(String cityName) {
    return repository.removeFavoriteCity(cityName);
  }
}
