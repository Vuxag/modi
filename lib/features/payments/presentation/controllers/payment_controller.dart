import 'package:get/get.dart';
import 'package:local_services_marketplace/core/network/api_client.dart';
import 'package:local_services_marketplace/shared/models/payment_model.dart';

class PaymentController extends GetxController {
  final ApiClient _apiClient;

  final Rx<Payment?> currentPayment = Rx<Payment?>(null);
  final RxList<Payment> paymentHistory = <Payment>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  PaymentController(this._apiClient);

  Future<void> createPayment({
    required String bookingId,
    required double amount,
    required String currency,
    required String paymentMethod,
    PaymentDetails? details,
  }) async {
    try {
      isLoading.value = true;
      error.value = '';

      final body = {
        'bookingId': bookingId,
        'amount': amount,
        'currency': currency,
        'paymentMethod': paymentMethod,
        if (details != null) 'details': details.toJson(),
      };

      final result = await _apiClient.createPayment(body);
      currentPayment.value = result;

      Get.snackbar(
        'Success',
        'Payment initiated successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      error.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to initiate payment: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getPaymentDetails(String paymentId) async {
    try {
      isLoading.value = true;
      error.value = '';

      final result = await _apiClient.getPayment(paymentId);
      currentPayment.value = result;
    } catch (e) {
      error.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to get payment details: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createInstallments({
    required String paymentId,
    required int numberOfInstallments,
    required double amountPerInstallment,
  }) async {
    try {
      isLoading.value = true;
      error.value = '';

      final body = {
        'numberOfInstallments': numberOfInstallments,
        'amountPerInstallment': amountPerInstallment,
      };

      final result = await _apiClient.createInstallments(paymentId, body);
      currentPayment.value = result;

      Get.snackbar(
        'Success',
        'Installment plan created successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      error.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to create installment plan: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  bool isPaymentSuccessful() {
    return currentPayment.value?.status == 'COMPLETED';
  }

  bool isPaymentPending() {
    return currentPayment.value?.status == 'PENDING';
  }

  bool isPaymentFailed() {
    return currentPayment.value?.status == 'FAILED';
  }

  bool hasInstallments() {
    return currentPayment.value?.installments?.isNotEmpty ?? false;
  }

  List<PaymentInstallment> getInstallments() {
    return currentPayment.value?.installments ?? [];
  }

  PaymentDetails? getPaymentInfo() {
    return currentPayment.value?.details;
  }
}
