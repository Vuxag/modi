import 'package:get/get.dart';
import 'package:local_services_marketplace/core/network/api_client.dart';
import 'package:local_services_marketplace/shared/models/review_model.dart';

class ReviewController extends GetxController {
  final ApiClient _apiClient;
  final reviews = <Review>[].obs;
  final isLoading = false.obs;
  final isCreatingReview = false.obs;
  final isReplying = false.obs;
  final isReporting = false.obs;
  final error = RxnString();
  final showVerifiedOnly = false.obs;

  ReviewController(this._apiClient);

  Future<void> loadServiceReviews(String serviceId) async {
    try {
      isLoading.value = true;
      error.value = null;
      final response = await _apiClient.getServiceReviews(serviceId);
      reviews.value = response;
    } on ApiException catch (e) {
      error.value = e.message;
      Get.snackbar(
        'Error',
        'Failed to load reviews: ${e.message}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      error.value = 'An unexpected error occurred';
      Get.snackbar(
        'Error',
        'An unexpected error occurred while loading reviews',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void sortByRating() {
    try {
      reviews.sort((a, b) => b.rating.compareTo(a.rating));
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to sort reviews',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void sortByDate() {
    try {
      reviews.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to sort reviews',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> createReview(
    String serviceId,
    int rating,
    String comment,
    List<String> tags,
  ) async {
    if (isCreatingReview.value) return;

    try {
      isCreatingReview.value = true;
      error.value = null;
      final review = await _apiClient.createReview({
        'serviceId': serviceId,
        'rating': rating,
        'comment': comment,
        'tags': tags,
      });
      reviews.add(review);
      Get.snackbar(
        'Success',
        'Review created successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on ApiException catch (e) {
      error.value = e.message;
      Get.snackbar(
        'Error',
        'Failed to create review: ${e.message}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      error.value = 'An unexpected error occurred';
      Get.snackbar(
        'Error',
        'An unexpected error occurred while creating review',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isCreatingReview.value = false;
    }
  }

  Future<void> replyToReview(String reviewId, String comment) async {
    if (isReplying.value) return;

    try {
      isReplying.value = true;
      error.value = null;
      final updatedReview = await _apiClient.replyToReview(
        reviewId,
        {'comment': comment},
      );
      final index = reviews.indexWhere((r) => r.id == reviewId);
      if (index != -1) {
        reviews[index] = updatedReview;
      }
      Get.snackbar(
        'Success',
        'Reply sent successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on ApiException catch (e) {
      error.value = e.message;
      Get.snackbar(
        'Error',
        'Failed to send reply: ${e.message}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      error.value = 'An unexpected error occurred';
      Get.snackbar(
        'Error',
        'An unexpected error occurred while sending reply',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isReplying.value = false;
    }
  }

  Future<void> reportReview(String reviewId, String reason) async {
    if (isReporting.value) return;

    try {
      isReporting.value = true;
      error.value = null;
      await _apiClient.addReviewMedia(
        reviewId,
        {'type': 'report', 'reason': reason},
      );
      Get.snackbar(
        'Success',
        'Review reported successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on ApiException catch (e) {
      error.value = e.message;
      Get.snackbar(
        'Error',
        'Failed to report review: ${e.message}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      error.value = 'An unexpected error occurred';
      Get.snackbar(
        'Error',
        'An unexpected error occurred while reporting review',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isReporting.value = false;
    }
  }
}
