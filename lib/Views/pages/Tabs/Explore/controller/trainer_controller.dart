import 'dart:async';

import 'package:get/get.dart';

import '../../../../../services/api_service.dart';
import '../model/trainer.dart';

class ExploreController extends GetxController {
  var trainers = <Trainer>[].obs;
   var favoriteTrainers = <Trainer>[].obs;
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
}

 Future<List<Trainer>> fetchTrainers({String sort = 'asc', String specialization = ''}) async {
    Completer<List<Trainer>> completer = Completer<List<Trainer>>();
    try {
      final token = await apiService.getToken();
      if (token != null) {
        var fetchedTrainers;
        if (specialization.isNotEmpty) {
          fetchedTrainers = await apiService.fetchTrainersBySpecialization(token, specialization, sort);
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
  int index = trainers.indexWhere((t) => t.id == trainerId);
  if (index != -1) {
    trainers[index].isFavorite = !trainers[index].isFavorite;
    trainers.refresh(); 

    try {
      String? token = await apiService.getToken();
      if (token != null) {
        await apiService.toggleFavorite(trainerId, token);
      }
    } catch (e) {
      trainers[index].isFavorite = !trainers[index].isFavorite;  // Revert on error
     
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
