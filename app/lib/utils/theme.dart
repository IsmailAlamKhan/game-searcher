import 'package:flutter/material.dart';

ThemeData getAppThemeData([Color? seedColor]) {
  seedColor ??= const Color(0xFF5865F2);
  return ThemeData(
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
}
