import 'package:oshin_list/helper/date_time_helper.dart';

import 'package:task_repository/task_repository.dart';

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
  String get formatedDate => date?.formatedDate ?? '';
}


