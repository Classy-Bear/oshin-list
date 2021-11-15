// ignore_for_file: unnecessary_this

import 'package:task_repository/task_repository.dart';

enum Type { work, study, family }

extension SelectedColor on Task {
  int get selectedColor {
    if (this.color! > 1 && this.color! < 20) {
      return 1;
    } else if (this.color! > 20 && this.color! < 40) {
      return 997070;
    } else if (this.color! > 40 && this.color! < 60) {
      return 663399;
    } else if (this.color! > 60 && this.color! < 80) {
      return 008000;
    } else {
      return 008080;
    }
  }
}

extension SelectedType on Task {
  String get selectedType {
    if (this.type! > 1 && this.type! < 35) {
      return "${Type.family}";
    } else if (this.type! > 35 && this.type! < 70) {
      return "${Type.work}";
    } else if (this.type! > 70 && this.type! < 100) {
      return "${Type.study}";
    } else {
      return "${Type.work}";
    }
  }
}
