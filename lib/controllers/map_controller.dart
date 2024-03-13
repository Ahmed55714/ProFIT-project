import '../models/map_place.dart';
import '../services/api_service.dart';

class GymSearchController {
  Future<List<Place>> searchGyms(String query) async {
    return ApiService.searchPlaces(query);
  }
}