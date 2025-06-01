import 'package:get/get.dart';
import 'package:local_services_marketplace/features/auth/presentation/screens/login_screen.dart';
import 'package:local_services_marketplace/features/auth/presentation/screens/register_screen.dart';
import 'package:local_services_marketplace/features/services/presentation/screens/services_screen.dart';
import 'package:local_services_marketplace/features/services/presentation/screens/service_details_screen.dart';
import 'package:local_services_marketplace/features/settings/presentation/screens/settings_screen.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => const RegisterScreen(),
    ),
    GetPage(
      name: Routes.SERVICES,
      page: () => const ServicesScreen(),
    ),
    GetPage(
      name: Routes.SERVICE_DETAILS,
      page: () => const ServiceDetailsScreen(),
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => const SettingsScreen(),
    ),
  ];
}
