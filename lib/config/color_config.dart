import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class ThemeColor {
  // ref https://www.canva.com/colors/color-palettes/pastel-dreams/
  static final yellow = HexColor("#FBE7C6");
  static final mint = HexColor("#B4F8C8");
  static final tiffany_blue = HexColor("#A0E7E5");
  static final hot_pink = HexColor("#FFAEBC");
  static final white = Colors.white;
  static final tan = HexColor("#B64D40");
  static final cream = HexColor("#F4EBD0");
  static final charcoal = HexColor("#122620");
  static final gold = HexColor("#D6AD60");
  static final grey = HexColor("#808080");
  static final black = Colors.black;
}