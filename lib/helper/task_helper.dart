import 'package:task_repository/task_repository.dart';

enum Type { work, study, family }

extension SelectedColor on Task {
  int get selectedColor {
    if (color! > 1 && color! < 20) {
      return 1;
    } else if (this.color! > 20 && this.color! < 40) {
      return 0xff997070;
    } else if (this.color! > 40 && this.color! < 60) {
      return 0xff663399;
    } else if (this.color! > 60 && this.color! < 80) {
      return 0xff008000;
    } else {
      return 0xff008080;
    }
  }
}

extension SelectedType on Task {
  String get selectedType {
    if (this.type! > 1 && this.type! < 35) {
      return Type.family.toString().split('.')[1];
    } else if (this.type! > 35 && this.type! < 70) {
      return Type.work.toString().split('.')[1];
    } else if (this.type! > 70 && this.type! < 100) {
      return Type.study.toString().split('.')[1];
    } else {
      return Type.work.toString().split('.')[1];
    }
  }
}
