import 'package:flutter/material.dart';
import 'package:task_repository/task_repository.dart';

const pastelPink = 0xffF5B7B1;
const lightBrown = 0xff997070;
const purple = 0xff663399;
const green = 0xff008000;

/// Para definir los colores evuamos 4 rangos :
///[pastelPinkRange] 0-19   representa     [pastelPink]
///[lightBrownRange] 20-39  representa     [lightBrown]
///[purpleRange]     40-59  representa     [purple]
///[greenRange]      60-∞   representa     [green]

const pastelPinkRange = 1;
const purpleRange = 20;
const lightBrownRange = 40;
const greenRange = 60;

extension ColorTange on Color {
  int get colorRange {
    String colorStr = toString();
    String colorHex = colorStr.substring(
      (colorStr.indexOf('(') + 1),
      colorStr.lastIndexOf(')'),
    );
    int colorInt = int.tryParse(colorHex) ?? 0;
    switch (colorInt) {
      case pastelPink:
        return pastelPinkRange;
      case purple:
        return purpleRange;
      case lightBrown:
        return lightBrownRange;
      default:
        return greenRange;
    }
  }
}

int colorValidate(int? color) => color ?? Task.empty.color ?? 0;
