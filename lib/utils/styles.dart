
import 'package:flutter/material.dart';
class fontstyles{
  static const dr1= TextStyle(color: Color(0xFF6E6E6E),
    fontSize: 20,
    fontFamily: 'Inter',
    height: 0);
}

extension AppStylesExtension on TextStyle {
  TextStyle setColor(Color color) => copyWith(color: color);
  TextStyle setFontSize(double size) => copyWith(fontSize: size);
  TextStyle setFontWeight(FontWeight weight) => copyWith(fontWeight: weight);
  TextStyle setFontFamily(String family) => copyWith(fontFamily: family);
}