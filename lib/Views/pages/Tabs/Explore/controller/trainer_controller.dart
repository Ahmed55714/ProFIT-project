import 'dart:async';

import 'package:get/get.dart';

import '../../../../../services/api_service.dart';
import '../model/trainer.dart';

class ExploreController extends GetxController {
  var trainers = <Trainer>[].obs;
  var favoriteTrainers = <Trainer>[].obs;
  var trainer2 = <Trainer>[].obs; 
  final ApiService apiService = ApiService();


  @override
  void onInit() {
    super.onInit();
    _loadTrainers();
  }

  void _loadTrainers() async {
    try {
      final token = await apiService.getToken();
      if (token != null) {
        var fetchedTrainers = await apiService.fetchAllTrainers(token);
        if (fetchedTrainers.isNotEmpty) {
          trainers.assignAll(fetchedTrainers);
          print('Trainers loaded: ${trainers.length}');
        } else {
          print("No trainers fetched from API.");
        }
      } else {
        Get.snackbar('Error', 'Authentication token not found');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch trainers: $e');
      print('Error fetching trainers: $e');
    }
    trainers.assignAll(trainers);
  }
Future<List<Trainer>> fetchTrainersForTrainer2() async {
  try {
    final token = await apiService.getToken();
    if (token != null) {
      var fetchedTrainers = await apiService.fetchAllTrainers(token);
      if (fetchedTrainers.isNotEmpty) {
        trainer2.assignAll(fetchedTrainers);
        print('Trainers for Trainer2 loaded: ${trainer2.length}');
        return fetchedTrainers;
      } else {
        print("No trainers fetched for Trainer2 from API.");
        return [];
      }
    } else {
      Get.snackbar('Error', 'Authentication token not found');
      return [];
    }
  } catch (e) {
    Get.snackbar('Error', 'Failed to fetch trainers for Trainer2: $e');
    print('Error fetching trainers for Trainer2: $e');
    return [];
  }
}
  Future<List<Trainer>> fetchTrainers(
      {String sort = 'asc', String specialization = ''}) async {
    Completer<List<Trainer>> completer = Completer<List<Trainer>>();
    try {
      final token = await apiService.getToken();
      if (token != null) {
        var fetchedTrainers;
        if (specialization.isNotEmpty) {
          fetchedTrainers = await apiService.fetchTrainersBySpecialization(
              token, specialization, sort);
        } else {
          fetchedTrainers = await apiService.fetchTrainers(token, sort: sort);
        }
        if (fetchedTrainers.isNotEmpty) {
          trainers.assignAll(fetchedTrainers);
          completer.complete(fetchedTrainers);
        } else {
          print("No trainers fetched from API.");
          completer.complete([]);
        }
      } else {
        Get.snackbar('Error', 'Authentication token not found');
        completer.completeError('Authentication token not found');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch trainers: $e');
      print('Error fetching trainers: $e');
      completer.completeError(e);
    }
    return completer.future;
  }

  void sortTrainersLowToHigh() {
    fetchTrainers(sort: 'asc');
  }

  void sortTrainersHighToLow() {
    fetchTrainers(sort: 'desc');
  }

  void filterBySpecialization(String specialization) {
    fetchTrainers(specialization: specialization);
  }

void toggleFavorite(String trainerId) async {
    int index = trainer2.indexWhere((t) => t.id == trainerId);
    if (index != -1) {
        String? token = await apiService.getToken();
        if (token != null) {
            try {
                await apiService.toggleFavorite(trainerId, token);
                trainer2[index].isFavorite = !trainer2[index].isFavorite;
                trainer2.refresh();
            } catch (e) {
                print('Error toggling favorite: $e');
            }
        }
    }
}



  void fetchFavoriteTrainers() async {
    try {
      final token = await apiService.getToken();
      if (token != null) {
        var fetchedFavorites = await apiService.fetchFavoriteTrainers(token);
        if (fetchedFavorites.isNotEmpty) {
          favoriteTrainers.assignAll(fetchedFavorites);
          print('Favorite trainers loaded: ${favoriteTrainers.length}');
       
        } else {
          print("No favorite trainers fetched from API.");
        }
      } else {
        // Get.snackbar('Error', 'Authentication token not found');
      }
    } catch (e) {
      // Get.snackbar('Error', 'Failed to fetch favorite trainers: $e');
      print('Error fetching favorite trainers: $e');
    }
  }
}
