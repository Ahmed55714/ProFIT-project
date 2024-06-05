import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../../services/api_service.dart';
import '../model/photo.dart';

class PhotoController extends GetxController {
  var photos = <Photo>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  final ApiService apiService;

  PhotoController(this.apiService);

  @override
  void onInit() {
    fetchPhotos();
    super.onInit();
  }

  void fetchPhotos() async {
    try {
      isLoading(true);
      var fetchedPhotos = await apiService.fetchPhotos();
      photos.assignAll(fetchedPhotos.map((photo) {
        return Photo(
          id: photo.id,
          photoUrl: photo.photoUrl,
          createdAt: DateFormat('dd MMM, yyyy').format(DateTime.parse(photo.createdAt)),
        );
      }).toList());
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

   void deletePhoto(String photoId) async {
    try {
      isLoading(true);
      final success = await apiService.deletePhoto(photoId);
      if (success) {
        photos.removeWhere((photo) => photo.id == photoId);
      } else {
        Get.snackbar('Error', 'Failed to delete photo');
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
