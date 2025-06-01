import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_services_marketplace/core/routes/app_pages.dart';
import 'package:local_services_marketplace/core/network/api_client.dart';
import 'package:local_services_marketplace/features/auth/presentation/controllers/auth_controller.dart';
import 'package:local_services_marketplace/features/services/presentation/controllers/services_controller.dart';
import 'package:local_services_marketplace/features/services/presentation/controllers/tags_controller.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize dependencies
    final dio = Dio(BaseOptions(
      baseUrl: 'https://api.example.com/v1',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Add logging interceptor in debug mode
    assert(() {
      dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
      ));
      return true;
    }());

    final apiClient = ApiClient(dio);

    // Initialize controllers
    Get.put(AuthController(apiClient));
    Get.put(ServicesController(apiClient));
    Get.put(TagsController(apiClient));

    return GetMaterialApp(
      title: 'Local Services Marketplace',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      defaultTransition: Transition.fade,
    );
  }
}
