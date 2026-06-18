import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/l10n/generated/app_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/locale_provider.dart';
import '../providers/theme_provider.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    final isDark = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.settings,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppTheme.background,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        children: [
          ListTile(
            leading: const Icon(Icons.dark_mode_outlined, color: AppTheme.primary),
            title: Text(l10n.darkMode, style: Theme.of(context).textTheme.bodyLarge),
            trailing: Switch(
              value: isDark,
              onChanged: (value) {
                themeProvider.toggleTheme(value);
              },
            ),
          ),
          const Divider(color: AppTheme.outlineVariant),
          ListTile(
            leading: const Icon(Icons.language, color: AppTheme.primary),
            title: Text(l10n.language, style: Theme.of(context).textTheme.bodyLarge),
            trailing: DropdownButton<Locale>(
              value: localeProvider.locale,
              underline: const SizedBox(),
              icon: const Icon(Icons.arrow_drop_down, color: AppTheme.primary),
              onChanged: (Locale? newLocale) {
                if (newLocale != null) {
                  localeProvider.setLocale(newLocale);
                }
              },
              items: const [
                DropdownMenuItem(value: Locale('en'), child: Text('English')),
                DropdownMenuItem(value: Locale('ru'), child: Text('Русский')),
                DropdownMenuItem(value: Locale('az'), child: Text('Azərbaycan')),
              ],
            ),
          ),
          const Divider(color: AppTheme.outlineVariant),
          ListTile(
            leading: const Icon(Icons.notifications_none, color: AppTheme.primary),
            title: Text(l10n.notifications, style: Theme.of(context).textTheme.bodyLarge),
            trailing: Switch(
              value: true,
              onChanged: (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Notifications settings coming soon!')),
                );
              },
            ),
          ),
          const Divider(color: AppTheme.outlineVariant),
          const SizedBox(height: 32),
          Center(
            child: Column(
              children: [
                SvgPicture.asset('assets/logo.svg', width: 64, height: 64),
                const SizedBox(height: 16),
                Text(
                  l10n.appTitle,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Version 1.0.0',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
