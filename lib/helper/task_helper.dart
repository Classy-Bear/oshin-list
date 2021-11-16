import 'package:task_repository/task_repository.dart';

enum Type { work, study, family }

extension SelectedColor on Task {
  int get selectedColor {
    if (color! > 1 && color! < 20) {
      return 1;
    } else if (color! > 20 && color! < 40) {
      return 997070;
    } else if (color! > 40 && color! < 60) {
      return 663399;
    } else if (color! > 60 && color! < 80) {
      return 008000;
    } else {
      return 008080;
    }
  }
}

extension SelectedType on Task {
  String get selectedType {
    if (type! > 1 && type! < 35) {
      return "${Type.family}";
    } else if (type! > 35 && type! < 70) {
      return "${Type.work}";
    } else if (type! > 70 && type! < 100) {
      return "${Type.study}";
    } else {
      return "${Type.work}";
    }
  }
}
