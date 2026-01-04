import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SettingsScreenThemeModeDialog extends HookWidget {
  const SettingsScreenThemeModeDialog({super.key, required this.currentMode});
  final ThemeMode currentMode;

  @override
  Widget build(BuildContext context) {
    final themeMode = useState(currentMode);
    return AlertDialog(
      title: const Text('Choose theme mode'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final mode in ThemeMode.values)
            RadioGroup(
              groupValue: themeMode.value,
              onChanged: (value) {
                if (value != null) {
                  themeMode.value = value;
                }
              },
              child: RadioListTile(title: Text(mode.name), value: mode),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(themeMode.value),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
