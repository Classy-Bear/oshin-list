import 'package:flutter/material.dart';
import 'package:task_repository/task_repository.dart';

/// Para definir los colores evaluamos 4 rangos :

///[pastelPinkRange] 0-19   representa     [pastelPink]
const pastelPinkRange = 1;

///[purpleRange]     20-39  representa     [purple]
const purpleRange = 20;

///[lightBrownRange] 40-59  representa     [lightBrown]
const lightBrownRange = 40;

///[greenRange]      60-∞   representa     [green]
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
