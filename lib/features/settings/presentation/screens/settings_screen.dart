import 'package:flutter/material.dart';
import 'package:local_services_marketplace/core/localization/app_localizations.dart';
import 'package:local_services_marketplace/features/settings/presentation/widgets/language_selector.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.settings),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const LanguageSelector(),
          const SizedBox(height: 24),
          _buildSection(
            context,
            title: AppLocalizations.notifications,
            icon: Icons.notifications_outlined,
            onTap: () {
              // TODO: Navigate to notifications settings
            },
          ),
          _buildSection(
            context,
            title: AppLocalizations.theme,
            icon: Icons.palette_outlined,
            onTap: () {
              // TODO: Navigate to theme settings
            },
          ),
          _buildSection(
            context,
            title: AppLocalizations.help,
            icon: Icons.help_outline,
            onTap: () {
              // TODO: Navigate to help screen
            },
          ),
          _buildSection(
            context,
            title: AppLocalizations.about,
            icon: Icons.info_outline,
            onTap: () {
              // TODO: Navigate to about screen
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
