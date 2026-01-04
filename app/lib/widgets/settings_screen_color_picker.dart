import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../utils/theme.dart';

const colors = [
  defaultSeedColor,
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
  Colors.blueGrey,
];

class SettingsScreenColorPicker extends HookWidget {
  const SettingsScreenColorPicker({super.key, this.currentColor});
  final Color? currentColor;

  @override
  Widget build(BuildContext context) {
    final color = useState(currentColor);
    final theme = Theme.of(context);
    return Theme(
      data: getAppThemeData(color.value, theme.brightness),
      child: AlertDialog(
        title: const Text('Choose theme color'),
        content: SizedBox(
          width: 300,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: colors.length,
            itemBuilder: (context, index) {
              final item = colors[index];
              final isSelected = color.value?.toARGB32() == item.toARGB32();

              return Card(
                clipBehavior: Clip.antiAlias,
                shape: CircleBorder(
                  side: BorderSide(
                    color: isSelected ? Colors.white : Colors.transparent,
                    width: 3,
                  ),
                ),
                color: item,
                margin: EdgeInsets.zero,
                elevation: 0,

                child: InkWell(
                  onTap: () {
                    color.value = item;
                  },
                  child: isSelected ? const Icon(Icons.check, color: Colors.white) : null,
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop(defaultSeedColor);
            },
            child: const Text('Reset'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop(color.value);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
