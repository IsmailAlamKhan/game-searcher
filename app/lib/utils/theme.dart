import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color defaultSeedColor = const Color(0xFF202e63);
ThemeData getAppThemeData([Color? seedColor]) {
  seedColor ??= defaultSeedColor;

  ThemeData theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
      dynamicSchemeVariant: DynamicSchemeVariant.content,
    ),
    useMaterial3: true,
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        borderSide: BorderSide(width: 0, color: Colors.transparent),
        gapPadding: 0,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        borderSide: BorderSide(width: 0, color: Colors.transparent),
        gapPadding: 0,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        borderSide: BorderSide(width: 0, color: Colors.transparent),
        gapPadding: 0,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        borderSide: BorderSide(width: 0, color: Colors.transparent),
        gapPadding: 0,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        borderSide: BorderSide(width: 0, color: Colors.transparent),
        gapPadding: 0,
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        borderSide: BorderSide(width: 0, color: Colors.transparent),
        gapPadding: 0,
      ),
      filled: true,
    ),
  );
  final textTheme = GoogleFonts.electrolizeTextTheme(theme.textTheme);
  theme = theme.copyWith(textTheme: textTheme);

  return theme;
}
