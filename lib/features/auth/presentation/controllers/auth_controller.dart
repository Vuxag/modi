import 'package:get/get.dart';
import 'package:local_services_marketplace/core/network/api_client.dart';
import 'package:local_services_marketplace/core/routes/app_routes.dart';
import 'package:local_services_marketplace/shared/models/user_model.dart';

class AuthController extends GetxController {
  final ApiClient _apiClient;
  final email = ''.obs;
  final password = ''.obs;
  final isLoading = false.obs;
  final error = ''.obs;

  AuthController(this._apiClient);

  Future<void> login() async {
    try {
      isLoading.value = true;
      error.value = '';

      final response = await _apiClient.login({
        'email': email.value,
        'password': password.value,
      });

      // TODO: Store token and user data
      Get.offAllNamed(Routes.SERVICES);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      isLoading.value = true;
      error.value = '';

      final user = await _apiClient.register({
        'name': name,
        'email': email,
        'password': password,
      });

      // TODO: Store token and user data
      Get.offAllNamed(Routes.SERVICES);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    // TODO: Clear token and user data
    Get.offAllNamed(Routes.LOGIN);
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
