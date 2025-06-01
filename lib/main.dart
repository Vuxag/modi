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
    final dio = Dio();
    final apiClient = ApiClient(
      dio,
      baseUrl: 'https://api.example.com', // Replace with your API base URL
    );

    // Register dependencies
    Get.put(apiClient);
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
