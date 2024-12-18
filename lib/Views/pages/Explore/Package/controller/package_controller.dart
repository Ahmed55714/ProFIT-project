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
      var fetchedPackages = await apiService.getPackagesById(id);
      packages.value = fetchedPackages;
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }

  Future<void> selectPackage(String packageId) async {
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

