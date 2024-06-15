import 'dart:async';
import 'package:get/get.dart';
import '../../../../../services/api_service.dart';
import '../model/trainer.dart';

class ExploreController extends GetxController {
  var trainers = <Trainer>[].obs;
  var favoriteTrainers = <Trainer>[].obs;
  var trainer2 = <Trainer>[].obs; 
  var trainersAtoZ = <Trainer>[].obs;
  var trainersZtoA = <Trainer>[].obs;
  final ApiService apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchTrainersForTrainer2();
    fetchTrainers();
  }

  Future<void> fetchTrainersForTrainer2() async {
    try {
      final token = await apiService.getToken();
      if (token != null) {
        var fetchedTrainers = await apiService.fetchAllTrainers(token);
        if (fetchedTrainers.isNotEmpty) {
          trainer2.assignAll(fetchedTrainers);
          updateSortedLists();
          print('Trainers for Trainer2 loaded: ${trainer2.length}');
        } else {
          print("No trainers fetched for Trainer2 from API.");
        }
      } else {
        Get.snackbar('Error', 'Authentication token not found');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch trainers for Trainer2: $e');
      print('Error fetching trainers for Trainer2: $e');
    }
  }

  Future<void> fetchTrainers({String sort = 'asc', String specialization = ''}) async {
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
          updateSortedLists();
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
          updateSortedLists();
        } catch (e) {
          print('Error toggling favorite: $e');
        }
      }
    }
  }

  Future<void> fetchFavoriteTrainers() async {
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
        Get.snackbar('Error', 'Authentication token not found');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch favorite trainers: $e');
      print('Error fetching favorite trainers: $e');
    }
  }

  void updateSortedLists() {
    trainersAtoZ.assignAll(List.from(trainer2)..sort((a, b) => a.fullName.compareTo(b.fullName)));
    trainersZtoA.assignAll(List.from(trainer2)..sort((a, b) => b.fullName.compareTo(a.fullName)));
  }
}


// import 'dart:async';
// import 'package:get/get.dart';
// import '../../../../../services/api_service.dart';
// import '../model/trainer.dart';

// class ExploreController extends GetxController {
//   var trainers = <Trainer>[].obs;
//   var favoriteTrainers = <Trainer>[].obs;
//   var trainer2 = <Trainer>[].obs;
//   var unsortedTrainer2 = <Trainer>[].obs;
//   final ApiService apiService = ApiService();

//   @override
//   void onInit() {
//     super.onInit();
//     fetchTrainersForTrainer2();
//     fetchTrainers();
//   }

//   Future<void> fetchTrainersForTrainer2() async {
//     try {
//       final token = await apiService.getToken();
//       if (token != null) {
//         var fetchedTrainers = await apiService.fetchAllTrainers(token);
//         if (fetchedTrainers.isNotEmpty) {
//           var sortedTrainers = List<Trainer>.from(fetchedTrainers)..sort((a, b) => a.fullName.compareTo(b.fullName)); // Sort trainers A to Z
//           trainer2.assignAll(sortedTrainers);
//           unsortedTrainer2.assignAll(fetchedTrainers); // Assign unsorted list as well
//           print('Trainers for Trainer2 loaded: ${trainer2.length}');
//         } else {
//           print("No trainers fetched for Trainer2 from API.");
//         }
//       } else {
//         Get.snackbar('Error', 'Authentication token not found');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to fetch trainers for Trainer2: $e');
//       print('Error fetching trainers for Trainer2: $e');
//     }
//   }

//   Future<void> fetchTrainers({String sort = 'asc', String specialization = ''}) async {
//     try {
//       final token = await apiService.getToken();
//       if (token != null) {
//         var fetchedTrainers;
//         if (specialization.isNotEmpty) {
//           fetchedTrainers = await apiService.fetchTrainersBySpecialization(token, specialization, sort);
//         } else {
//           fetchedTrainers = await apiService.fetchTrainers(token, sort: sort);
//         }
//         if (fetchedTrainers.isNotEmpty) {
//           if (sort == 'asc') {
//             fetchedTrainers.sort((a, b) => a.fullName.compareTo(b.fullName)); // Sort trainers A to Z
//           } else {
//             fetchedTrainers.sort((a, b) => b.fullName.compareTo(a.fullName)); // Sort trainers Z to A
//           }
//           trainers.assignAll(fetchedTrainers);
//           print('Fetched and sorted trainers: ${trainers.length}');
//           print('Trainers List: ${trainers.map((t) => t.fullName).toList()}');
//         } else {
//           print("No trainers fetched from API.");
//         }
//       } else {
//         Get.snackbar('Error', 'Authentication token not found');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to fetch trainers: $e');
//       print('Error fetching trainers: $e');
//     }
//   }

//   void sortTrainersLowToHigh() {
//     fetchTrainers(sort: 'asc');
//   }

//   void sortTrainersHighToLow() {
//     fetchTrainers(sort: 'desc');
//   }

//   void filterBySpecialization(String specialization) {
//     fetchTrainers(specialization: specialization);
//   }

//   void toggleFavorite(String trainerId) async {
//     int index = trainer2.indexWhere((t) => t.id == trainerId);
//     if (index != -1) {
//       String? token = await apiService.getToken();
//       if (token != null) {
//         try {
//           await apiService.toggleFavorite(trainerId, token);
//           trainer2[index].isFavorite = !trainer2[index].isFavorite;
//           trainer2.refresh();
//         } catch (e) {
//           print('Error toggling favorite: $e');
//         }
//       }
//     }
//   }

//   Future<void> fetchFavoriteTrainers() async {
//     try {
//       final token = await apiService.getToken();
//       if (token != null) {
//         var fetchedFavorites = await apiService.fetchFavoriteTrainers(token);
//         if (fetchedFavorites.isNotEmpty) {
//           favoriteTrainers.assignAll(fetchedFavorites);
//           print('Favorite trainers loaded: ${favoriteTrainers.length}');
//         } else {
//           print("No favorite trainers fetched from API.");
//         }
//       } else {
//         Get.snackbar('Error', 'Authentication token not found');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to fetch favorite trainers: $e');
//       print('Error fetching favorite trainers: $e');
//     }
//   }
// }
