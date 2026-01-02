import 'package:flutter/material.dart';

Size getTextSize(String text, TextStyle style, BuildContext context) {
  final defaultTextStyle = DefaultTextStyle.of(context).style;
  final textPainter = TextPainter(
    text: TextSpan(text: text, style: defaultTextStyle.merge(style)),
    textDirection: TextDirection.ltr,
  );
  textPainter.layout();
  return textPainter.size;
}
