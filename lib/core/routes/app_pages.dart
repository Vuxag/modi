import 'package:get/get.dart';
import 'package:local_services_marketplace/features/auth/presentation/login_screen.dart';
import 'package:local_services_marketplace/features/services/presentation/services_screen.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: Routes.SERVICES,
      page: () => ServicesScreen(),
    ),
  ];
}
