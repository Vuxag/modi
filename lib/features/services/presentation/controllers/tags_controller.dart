import 'package:get/get.dart';
import 'package:local_services_marketplace/core/network/api_client.dart';
import 'package:local_services_marketplace/shared/models/tag_model.dart';

class TagsController extends GetxController {
  final ApiClient _apiClient;
  final RxList<Tag> tags = <Tag>[].obs;
  final RxList<Tag> popularTags = <Tag>[].obs;
  final RxBool isLoading = false.obs;
  final RxString selectedParentId = ''.obs;
  final RxString error = ''.obs;

  TagsController(this._apiClient);

  @override
  void onInit() {
    super.onInit();
    loadTags();
    loadPopularTags();
  }

  Future<void> loadTags({String? parentId}) async {
    try {
      error.value = '';
      isLoading.value = true;
      final result = await _apiClient.getTags(parentId);
      tags.value = result;
    } catch (e) {
      error.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to load tags: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadPopularTags() async {
    try {
      error.value = '';
      isLoading.value = true;
      final result = await _apiClient.getPopularTags();
      popularTags.value = result;
    } catch (e) {
      error.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to load popular tags: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> createTag(String name, String? parentId) async {
    try {
      error.value = '';
      isLoading.value = true;
      final tag = await _apiClient.createTag({
        'name': name,
        'parentId': parentId,
      });
      tags.add(tag);
      Get.snackbar(
        'Success',
        'Tag created successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } catch (e) {
      error.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to create tag: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addTagsToService(String serviceId, List<String> tagIds) async {
    try {
      error.value = '';
      isLoading.value = true;
      await _apiClient.addTagsToService(serviceId, tagIds);
      Get.snackbar(
        'Success',
        'Tags added successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } catch (e) {
      error.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to add tags: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> setParentId(String? parentId) async {
    selectedParentId.value = parentId ?? '';
    await loadTags(parentId: parentId);
  }

  List<Tag> getChildTags(String parentId) {
    return tags.where((tag) => tag.parentId == parentId).toList();
  }

  List<Tag> getRootTags() {
    return tags.where((tag) => tag.parentId == null).toList();
  }

  void clearError() {
    error.value = '';
  }
}
