import 'package:flutter/material.dart';

int colorRange(Color color) {
  String colorStr = color.toString();
  String colorHex = colorStr.substring(
    (colorStr.indexOf('(') + 1),
    colorStr.lastIndexOf(')'),
  );
  int colorInt = int.tryParse(colorHex) ?? 0;
  switch (colorInt) {
    case 0xffF5B7B1:
      return 2;
    case 0xff997070:
      return 21;
    case 0xff663399:
      return 59;
    default:
      return 81;
  }
}
