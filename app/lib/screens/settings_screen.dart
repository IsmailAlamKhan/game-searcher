import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../providers/app_provider.dart';
import '../services/package_service.dart';
import '../utils/constants.dart';
import '../widgets/settings_screen_color_picker.dart';
import '../widgets/settings_screen_theme_mode_dialog.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final packageInfo = ref.watch(packageInfoProvider);

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Title
          Text(
            'Settings',
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 32),

          // Auto-Update Settings Section
          _buildSectionHeader('Auto-Update Settings(Coming Soon)', Icons.system_update, theme),
          const SizedBox(height: 16),
          _buildAutoUpdateSettings(),
          const SizedBox(height: 32),

          // Appearance Section
          _buildSectionHeader('Appearance', Icons.palette, theme),
          const SizedBox(height: 16),
          _buildAppearanceSettings(),
          const SizedBox(height: 32),

          // Content Filtering Section
          _buildSectionHeader('Content Filtering', Icons.blur_on, theme),
          const SizedBox(height: 16),
          _buildContentFilteringSettings(),
          const SizedBox(height: 32),

          // About Section
          _buildSectionHeader('About', Icons.info_outline, theme),
          const SizedBox(height: 16),
          _buildAboutSection(packageInfo),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, ThemeData theme) {
    return Row(
      children: [
        Icon(icon, color: theme.colorScheme.primary),
        const SizedBox(width: 12),
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildAutoUpdateSettings() {
    final state = ref.watch(appControllerProvider);
    final autoUpdateEnabled = state.autoUpdateEnabled;
    final interval = state.autoUpdateInterval;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          SwitchListTile(
            title: const Text('Enable auto-updates'),
            subtitle: const Text('Automatically check for new versions'),
            value: autoUpdateEnabled,
            onChanged: null,
            // (value) {
            //   controller.setAutoUpdateEnabled(value);
            // },
          ),

          const Divider(height: 1),
          ListTile(
            title: const Text('Check interval'),
            subtitle: Text('Currently: ${_formatInterval(interval)}'),
            // enabled: autoUpdateEnabled,
            enabled: false,
            trailing: const Icon(Icons.chevron_right),
            onTap: autoUpdateEnabled ? () => _showIntervalDialog(interval) : null,
          ),
        ],
      ),
    );
  }

  Widget _buildContentFilteringSettings() {
    final state = ref.watch(appControllerProvider);
    final controller = ref.watch(appControllerProvider.notifier);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          SwitchListTile(
            title: const Text('Blur adult content'),
            subtitle: const Text('Blur out adult content in search results and tag'),
            value: state.blurAdultContent,
            onChanged: (value) {
              controller.setBlurAdultContent(value);
            },
          ),

          // const Divider(height: 1),
          // ListTile(
          //   title: const Text('Content filtering level'),
          //   subtitle: Text('Currently: ${_formatContentFilteringLevel(contentFilteringLevel)}'),
          //   // enabled: contentFilteringEnabled,
          //   enabled: false,
          //   trailing: const Icon(Icons.chevron_right),
          //   onTap: contentFilteringEnabled ? () => _showContentFilteringLevelDialog(contentFilteringLevel) : null,
          // ),
        ],
      ),
    );
  }

  Widget _buildAppearanceSettings() {
    final state = ref.watch(appControllerProvider);
    final controller = ref.watch(appControllerProvider.notifier);
    final themeMode = state.themeMode;
    final seedColor = state.themeSeedColor;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            title: const Text('Theme mode'),
            subtitle: Text(_formatThemeMode(themeMode)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              final _themeMode = await _showThemeModeDialog(themeMode);
              if (_themeMode != null) {
                controller.setThemeMode(_themeMode);
              }
            },
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('Theme color'),
            subtitle: const Text('Choose your preferred primary color'),
            trailing: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: seedColor ?? Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                  width: 2,
                ),
              ),
            ),
            onTap: () async {
              final _seedColor = await _showColorPicker(seedColor);
              if (_seedColor != null) {
                controller.setThemeSeedColor(color: _seedColor);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection(PackageInfo packageInfo) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Version'),
            subtitle: Text('${packageInfo.version} (${packageInfo.buildNumber})'),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Developer'),
            subtitle: const Text('Ismail Alam Khan'),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.code),
            title: const Text('GitHub Repository'),
            subtitle: const Text('View source code'),
            trailing: const Icon(Icons.open_in_new),
            onTap: () => launchUrlWithLogging('https://github.com/IsmailAlamKhan/game-searcher'),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.gavel),
            title: const Text('License'),
            subtitle: const Text('MIT License'),
          ),
          const Divider(height: 1),
          ExpansionTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Credits'),
            children: [
              ListTile(
                title: Text(rawgApiName),
                subtitle: Text(rawgApiAttribution),
                trailing: const Icon(Icons.open_in_new),
                onTap: () => launchUrlWithLogging(rawgApiUrl),
              ),
              const ListTile(
                title: Text('Flutter'),
                subtitle: Text('UI Framework by Google'),
              ),
              const ListTile(
                title: Text('Dart'),
                subtitle: Text('Programming Language by Google'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatInterval(Duration interval) {
    if (interval.inHours == 24) return 'Daily';
    if (interval.inHours == 24 * 7) return 'Weekly';
    return '${interval.inHours} hours';
  }

  String _formatThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  void _showIntervalDialog(Duration currentInterval) {
    final controller = ref.watch(appControllerProvider.notifier);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update check interval'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioGroup(
                groupValue: currentInterval.inHours,
                onChanged: (value) {
                  if (value != null) {
                    controller.setAutoUpdateInterval(Duration(hours: value));
                    Navigator.of(context).pop();
                    setState(() {});
                  }
                },
                child: RadioListTile(title: const Text('Daily'), value: 24),
              ),
              RadioGroup(
                groupValue: currentInterval.inHours,
                onChanged: (value) {
                  if (value != null) {
                    controller.setAutoUpdateInterval(Duration(hours: value));
                    Navigator.of(context).pop();
                    setState(() {});
                  }
                },
                child: RadioListTile(title: const Text('Weekly'), value: 24 * 7),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<ThemeMode?> _showThemeModeDialog(ThemeMode currentMode) {
    return showDialog<ThemeMode>(
      context: context,
      builder: (context) {
        return SettingsScreenThemeModeDialog(currentMode: currentMode);
      },
    );
  }

  Future<Color?> _showColorPicker(Color? currentColor) {
    // Predefined color palette

    return showDialog<Color>(
      context: context,
      builder: (context) {
        return SettingsScreenColorPicker(currentColor: currentColor);
      },
    );
  }
}
