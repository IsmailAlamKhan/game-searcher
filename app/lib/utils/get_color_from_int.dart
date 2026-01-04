import 'dart:ui';

Color getColorFromInt(int color) {
  return Color.fromARGB(
    color >> 24,
    color >> 16 & 0xFF,
    color >> 8 & 0xFF,
    color & 0xFF,
  );
}
