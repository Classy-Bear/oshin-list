import 'package:task_repository/task_repository.dart';

enum Type { work, study, family }

extension TaskHelper on Task {
  int get selectedColor {
    if (color! > 1 && color! < 20) {
      return 0xffF5B7B1;
    } else if (color! > 20 && color! < 40) {
      return 0xff997070;
    } else if (color! > 40 && color! < 60) {
      return 0xff663399;
    } else if (color! > 60 && color! < 80) {
      return 0xff008000;
    } else {
      return 0xff008080;
    }
  }

  String get selectedType {
    if (type! > 1 && type! < 35) {
      return Type.family.typeString;
    } else if (type! > 35 && type! < 70) {
      return Type.work.typeString;
    } else if (type! > 70 && type! < 100) {
      return Type.study.typeString;
    } else {
      return Type.work.typeString;
    }
  }

  String get formatedDate => date?.formatedDate ?? '';
}

extension TypeString on Type {
  String get typeString => toString().split('.')[1];
}

extension FormatedDate on DateTime {
  String get formatedDate {
    return "$day-$month-$year";
  }
}
