import 'package:get/get.dart';
import 'package:local_services_marketplace/core/network/api_client.dart';
import 'package:local_services_marketplace/shared/models/user_model.dart';

class AuthController extends GetxController {
  final ApiClient _apiClient;
  final Rx<User?> currentUser = Rx<User?>(null);
  final RxBool isLoading = false.obs;

  AuthController(this._apiClient);

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      final response = await _apiClient.login({
        'email': email,
        'password': password,
      });

      // Store token
      // Navigate to home
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(Map<String, dynamic> userData) async {
    try {
      isLoading.value = true;
      final user = await _apiClient.register(userData);
      currentUser.value = user;

      // Navigate to home
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      // Clear token
      currentUser.value = null;
      // Navigate to login
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> verifyPhone(String phone, String code) async {
    try {
      isLoading.value = true;
      await _apiClient.verifyPhone({
        'phone': phone,
        'code': code,
      });

      Get.snackbar(
        'Success',
        'Phone number verified successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
