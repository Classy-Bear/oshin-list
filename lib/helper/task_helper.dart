import 'package:task_repository/task_repository.dart';

enum Type { work, study, family }

extension SelectedColor on Task {
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
}

extension SelectedType on Task {
  String get selectedType {
    if (type! > 1 && type! < 35) {
      return getType(Type.family);
    } else if (type! > 35 && type! < 70) {
      return getType(Type.work);
    } else if (type! > 70 && type! < 100) {
      return getType(Type.study);
    } else {
      return getType(Type.work);
    }
  }
}

String getType(Enum typeEnum) {
  return typeEnum.toString().split('.')[1];
}

String date(DateTime date) {
  return "${date.day}-${date.month}-${date.year}";
}
