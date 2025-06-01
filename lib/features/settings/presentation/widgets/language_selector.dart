import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:local_services_marketplace/core/config/app_config.dart';
import 'package:local_services_marketplace/core/localization/app_localizations.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.language,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: AppConfig.supportedLanguages.map((lang) {
              final locale = Locale(lang);
              final isSelected = context.locale == locale;

              return ListTile(
                title: Text(
                  _getLanguageName(lang),
                  style: TextStyle(
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                trailing: isSelected
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () {
                  context.setLocale(locale);
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'vi':
        return 'Tiếng Việt';
      default:
        return code.toUpperCase();
    }
  }
}
