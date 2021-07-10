import 'package:flutter/material.dart';

Color g60Green = HexColor('0fe83f');
Color g60Red = HexColor('d5001c');
Color g60DarkBlue = HexColor('211652');
Color g60LightBlue = HexColor('1724c3');
Color g60ButtonColor = HexColor('#19181e');




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
