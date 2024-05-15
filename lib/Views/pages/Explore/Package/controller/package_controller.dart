import 'package:get/get.dart';

import '../../../../../services/api_service.dart';
import '../model/package.dart';

class PackageController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();
  var packages = <Package>[].obs;
  var isLoading = true.obs;

  void fetchPackagesById(String id) async {
    try {
      isLoading(true);
      print('Fetching packages for ID: $id');
      var fetchedPackages = await apiService.getPackagesById(id);
      packages.value = fetchedPackages;
    } catch (e) {
      print('Error in fetching packages: $e');
    } finally {
      isLoading(false);
    }
  }

  void selectPackage(String packageId) async {
  try {
    isLoading(true);
    print('Selecting package with ID: $packageId');
    String? token = await apiService.getToken();
    await apiService.selectPackage(packageId, token!);
  } catch (e) {
    print('Error selecting package: $e');
  } finally {
    isLoading(false);
  }
}

}

