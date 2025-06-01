import 'package:get/get.dart';
import 'package:local_services_marketplace/core/network/api_client.dart';
import 'package:local_services_marketplace/shared/models/service_model.dart';

class ServicesController extends GetxController {
  final ApiClient _apiClient;
  final RxList<Service> services = <Service>[].obs;
  final RxBool isLoading = false.obs;
  final RxString selectedCategory = ''.obs;
  final RxDouble currentLatitude = 0.0.obs;
  final RxDouble currentLongitude = 0.0.obs;
  final RxList<String> selectedTags = <String>[].obs;
  final RxString error = ''.obs;

  ServicesController(this._apiClient);

  @override
  void onInit() {
    super.onInit();
    loadServices();
  }

  Future<void> loadServices() async {
    try {
      error.value = '';
      isLoading.value = true;
      final result = await _apiClient.getServices(
        selectedTags.isEmpty ? null : selectedTags.join(','),
        currentLatitude.value,
        currentLongitude.value,
        10, // 10km radius
      );
      services.value = result;
    } catch (e) {
      error.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to load services: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadNearbyServices(double radius) async {
    try {
      error.value = '';
      isLoading.value = true;
      final result = await _apiClient.getNearbyServices(
        currentLatitude.value,
        currentLongitude.value,
        radius,
      );
      services.value = result;
    } catch (e) {
      error.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to load nearby services: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchServices(String query) async {
    try {
      error.value = '';
      isLoading.value = true;
      final result = await _apiClient.searchServices({
        'query': query,
        'category': selectedCategory.value,
        'tags': selectedTags.isEmpty ? null : selectedTags.join(','),
        'lat': currentLatitude.value,
        'lng': currentLongitude.value,
      });
      services.value = result;
    } catch (e) {
      error.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to search services: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> setCategory(String category) async {
    selectedCategory.value = category;
    await loadServices();
  }

  Future<void> updateLocation(double latitude, double longitude) async {
    currentLatitude.value = latitude;
    currentLongitude.value = longitude;
    await loadNearbyServices(10); // 10km radius
  }

  Future<void> toggleTag(String tagId) async {
    if (selectedTags.contains(tagId)) {
      selectedTags.remove(tagId);
    } else {
      selectedTags.add(tagId);
    }
    await loadServices();
  }

  Future<void> clearTags() async {
    selectedTags.clear();
    await loadServices();
  }

  List<Service> getFilteredServices({
    double? minPrice,
    double? maxPrice,
    double? minRating,
  }) {
    return services.where((service) {
      if (minPrice != null && service.price < minPrice) return false;
      if (maxPrice != null && service.price > maxPrice) return false;
      if (minRating != null && (service.rating ?? 0) < minRating) return false;
      return true;
    }).toList();
  }

  void clearError() {
    error.value = '';
  }
}
