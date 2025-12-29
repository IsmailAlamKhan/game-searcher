import 'package:flutter/material.dart';

Size getTextSize(String text, TextStyle style) {
  final textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: TextDirection.ltr,
  );
  textPainter.layout();
  return textPainter.size;
}
