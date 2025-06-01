import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_services_marketplace/core/localization/app_localizations.dart';
import 'package:local_services_marketplace/core/routes/app_routes.dart';
import 'package:local_services_marketplace/features/auth/presentation/controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.login),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: AppLocalizations.email,
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) => controller.email.value = value,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: AppLocalizations.password,
                border: const OutlineInputBorder(),
              ),
              obscureText: true,
              onChanged: (value) => controller.password.value = value,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => controller.login(),
              child: Text(AppLocalizations.login),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Get.toNamed(Routes.REGISTER),
              child: Text(AppLocalizations.register),
            ),
          ],
        ),
      ),
    );
  }
}
