import 'package:flutter/material.dart';

MaterialColor createMaterialColor(Color color) {
  List<double> strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((double strength) {
    final int ds = (strength * 255).round();
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ds,
      g + ds,
      b + ds,
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}